require 'gmail'
require 'yaml'
require 'date'

remaining_days = File.read('safebox_remaining_days')
params = YAML.load_file('configuration.yaml')

yesterday = Date.today.prev_day

Gmail.new(params['mailbox']['user_name'], params['mailbox']['password']) do |gmail|
  return File.write('safebox_remaining_days', 30) if gmail.label("[Gmail]/Messages envoy&AOk-s").count(:after => Date.parse(yesterday.strftime('%Y-%m-%d'))) == 0
end

Gmail.new(params['safebox']['user_name'], params['safebox']['password']) do |gmail|
  gmail.deliver do
    to "loic.chanel@gmail.com"
    subject 'Safebox warning'
    text_part do 
      body "Please answer this eMail within #{remaining_days} days or the safebox will be emptied"
    end
  end
  remaining_days -= 1
  
  File.write('safebox_remaining_days', remaining_days)
end
