class UserMailer < ActionMailer::Base
  default from: "admin@80000hours.org"

  def welcome_email(user)
    @name = user.first_name
    mail to: user.email, subject: "[80,000 Hours] New account"
  end
end
