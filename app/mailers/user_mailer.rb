class UserMailer < ActionMailer::Base
  default from: "admin@80000hours.org"
  
  def apply(user)
    @name = user.name
    @user_admin_url = admin_eighty_thousand_hours_application_url user.eighty_thousand_hours_application
    mail to: 'join@80000hours.org', subject: "[80,000 Hours] Application: #{user.name}"
  end
end
