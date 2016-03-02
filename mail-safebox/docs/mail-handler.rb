require 'mail'

remaining-days = 30

mail = Mail.new do
  from 'loic.chanel@safebox.com'
  to 'loic.chanel@gmail.com'
  subject 'Automatic safebox eMail'
  body "Please answer to this eMail within #{remaining-days} or the safebox will be emptied"
end
