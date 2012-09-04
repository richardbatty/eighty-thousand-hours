class EtkhProfileMailer < ActionMailer::Base
  default from: "admin@80000hours.org"
  
  def tell_team(user)
    @name = user.name
    @user_admin_url = admin_etkh_profile_url user.etkh_profile
    mail to: 'join@80000hours.org', subject: "[80,000 Hours] New member: #{user.name}"
  end

  def thank_applicant(user)
    @name = user.first_name
    mail to: user.email, subject: "[80,000 Hours] Welcome to 80,000 Hours!"
  end
end
