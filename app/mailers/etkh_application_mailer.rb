class EtkhApplicationMailer < ActionMailer::Base
  default from: "admin@80000hours.org"
  
  def tell_team(user)
    @name = user.name
    @user_admin_url = admin_etkh_application_url user.etkh_application
    mail to: 'join@80000hours.org', subject: "[80,000 Hours] Application: #{user.name}"
  end

  def thank_applicant(user)
    @name = user.first_name
    mail to: user.email, subject: "[80,000 Hours] Application received"
  end
end
