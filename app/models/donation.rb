class Donation < ActiveRecord::Base
  validates :member, :charity, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.01 }
  
  belongs_to :charity
  belongs_to :member
  
  after_create :send_confirmation_email_to_member
  
  private
    def send_confirmation_email_to_member
      DonationMailer.confirmation(self).deliver!
    end
end
