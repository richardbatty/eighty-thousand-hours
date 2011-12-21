class DonationMailer < ActionMailer::Base
  default from: "admin@80000hours.org"
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.donations.confirmed.subject
  #
  def confirmation(donation)
    @first_name = donation.member.first_name
    @amount = donation.amount
    @charity = donation.charity.name
    @member_page = user_url donation.member.user
    mail to: donation.member.email, subject: "Donation Confirmed"
  end
end
