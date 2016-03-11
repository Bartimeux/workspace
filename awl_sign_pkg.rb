require 'json'
require 'tempfile'

# Aller lire le fichier qui liste les repo à resigner
repolist = File.read('repo_to_resign.conf').split "\n"
repolist.each do |line|
  next if line.include? "#"
  next if line.empty?

  Dir["/DATA/repositories/#{line}/**/*.rpm"].each do |rpm|
    begin
      raise "#{rpm} not found" unless File.exist? rpm
      puts "Signing #{rpm}"
      Tempfile.open('sign-rpm-rpmmacros') do |f|
        begin
          f.write "
%_tmppath   /tmp
%_signature gpg
%_gpg_path  /DATA/GPG-keys/private
%_gpg_name  awl@repositories.priv.atos.fr

%__gpg_check_password_cmd /usr/bin/gpg --batch --no-verbose -u \"%{_gpg_name}\" -so -
%__gpg_sign_cmd /usr/bin/gpg --batch --no-verbose --no-armor --no-secmem-warning -u \"%{_gpg_name}\" -sbo %{__signature_filename} %{__plaintext_filename}
"
          f.close
          output = `/usr/bin/expect -c "spawn /bin/rpm -v --macros=#{f.path} --addsign #{rpm}" -c 'expect "pass phrase"' -c 'send -- "\r"' -c "expect eof" -c 'catch wait result' -c 'exit [lindex $result 3]' 2>&1`
          raise "rpm returns #{$?}: #{output}" unless $? == 0
        ensure
          f.close
          f.unlink
        end
      end
    rescue Exception => e
      raise "Unable to sign rpm #{rpm}: #{e.message}"
    end
  end
end
