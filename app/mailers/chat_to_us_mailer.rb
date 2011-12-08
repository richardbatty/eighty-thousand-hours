class ContactUsMailer < ActionMailer::Base
  default :from => "admin@80000hours.org"
 
  def chat_to_us_email(name,email,phone,skype,chat_options)
    @name = name
    @email = email
    @phone = phone
    @skype = skype
    @chat_options = chat_options
    mail(:to => "robbie.shade@80000hours.org", :subject => "[ChatToUs Request] #{name}")
  end
end
