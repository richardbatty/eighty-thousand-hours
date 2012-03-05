class Donation < ActiveRecord::Base
  validates :user, :charity, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.01 }
  
  belongs_to :charity
  belongs_to :user
  belongs_to :member
  
  after_create :send_confirmation_email_to_user
  
  private
    def send_confirmation_email_to_user
      DonationMailer.confirmation(self).deliver!
    end
end
