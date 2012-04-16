class DonationMailer < ActionMailer::Base
  default from: "admin@80000hours.org"
  
  def confirmation(donation)
    @first_name = donation.user.first_name
    @amount = donation.with_currency
    @cause = donation.cause.name
    @member_page = etkh_profile_url(donation.user)
    mail to: donation.user.email, subject: "[80,000 Hours] Donation being processed"
  end

  def accepted(donation)
    @first_name = donation.user.first_name
    @amount = donation.with_currency
    @cause = donation.cause.name
    @member_page = etkh_profile_url(donation.user)
    mail to: donation.user.email, subject: "[80,000 Hours] Donation accepted!"
  end
end
