require 'json'

# Aller lire le fichier de conf globale
CONF_FILE = "/etc/pds-packaging/config.json"
raise "Configuration file #{CONF_FILE} not found" unless File.readable? CONF_FILE
CONF = JSON.parse(IO.read(CONF_FILE), :symbolize_names => true)

# Aller lire le fichier qui liste les repo à resigner
repolist = File.read('repo_to_resign')
repolist.each do |repo|
  next if line.include? "#"
  next if line.empty?

  Dir["/DATA/repositories/#{repo}/**/*.rpm"].each do |rpm|
    begin
      raise "#{rpm} not found" unless File.exist? rpm
      log "Signing #{rpm}"
      Tempfile.open('sign-rpm-rpmmacros') do |f|
        begin
          f.write "
%_tmppath   /tmp
%_signature gpg
%_gpg_path  #{CONF[:dir][:keystore]}
%_gpg_name  awl@#{CONF[:gpg_mail_domain]}

%__gpg_check_password_cmd #{CONF[:bin][:gpg]} --batch --no-verbose -u \"%{_gpg_name}\" -so -
%__gpg_sign_cmd #{CONF[:bin][:gpg]} --batch --no-verbose --no-armor --no-secmem-warning -u \"%{_gpg_name}\" -sbo %{__signature_filename} %{__plaintext_filename}
"
          f.close
          output = `#{CONF[:bin][:expect]} -c "spawn #{CONF[:bin][:rpm]} -v --macros=#{f.path} --addsign #{rpm}" -c 'expect "pass phrase"' -c 'send -- "\r"' -c "expect eof" -c 'catch wait result' -c 'exit [lindex $result 3]' 2>&1`
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
