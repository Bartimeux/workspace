require 'gmail'
require 'yaml'
require 'date'

remaining_days = File.read('safebox_remaining_days')
params = YAML.load_file('configuration.yaml')
mails = YAML.load_file('mails.yaml')

yesterday = Date.today.prev_day

Gmail.new(params['safebox']['user_name'], params['safebox']['password']) do |gmail|
  return File.write('safebox_remaining_days', params['safebox_max_days']) if gmail.inbox.count(:from => params['user_personnal_mail'], :after => Date.parse(yesterday.strftime('%Y-%m-%d')))
end

if remaining_days == 0
  mails.each do |contact,mail_array|
    Gmail.new(params['safebox']['user_name'], params['safebox']['password']) do |gmail|
      gmail.deliver do
        to contact
        subject mails[contact]['object']
        text_part do
          body mails[contact]['body']
        end
      end
    end
  end
end
