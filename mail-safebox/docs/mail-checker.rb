require 'gmail'
require 'yaml'
require 'date'

remaining_days = File.read('safebox_remaining_days')
params = YAML.load_file('configuration.yaml')

Gmail.new(params['user_name'], params['password']) do |gmail|

  puts gmail.mailbox('Sent').count
  # puts gmail.mailbox('Sent').count(:after => Date.parse(Date.today.prev_day.strftime('%Y-%m-%d')))


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
