require 'gmail'
require 'yaml'


remaining_days = File.read('safebox_remaining_days')
params = YAML.load_file('configuration.yaml')

Gmail.new(params['user_name'], params['password']) do |gmail|

  gmail.deliver do
    to "loic.chanel@telecomnancy.net"
    subject 'Safebox warning'
    text_part do 
      body "Please answer this eMail within #{remaining_days} days or the safebox will be emptied"
    end
  end
  remaining_days -= 1
  
  File.write('safebox_remaining_days', remaining_days)
end
