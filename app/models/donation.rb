class Donation < ActiveRecord::Base
  validates :user, :charity, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.01 }
  
  belongs_to :charity
  belongs_to :user
  
  after_create :send_confirmation_email_to_user

  attr_accessible :charity, :charity_id, :amount, :receipt
  
  # paperclip gem for receipt uploads to s3
  has_attached_file :receipt,
                    :storage => :s3, 
                    :s3_credentials => { :access_key_id     => ENV['S3_ACCESS'],
                                         :secret_access_key => ENV['S3_SECRET'],
                                         :bucket            => ENV['S3_BUCKET'] },
                    :path => "/donations/:id/:filename"

  def confirm!
    self.confirmed = true
    self.save
    send_acceptance_email_to_user
  end

  private
    def send_confirmation_email_to_user
      DonationMailer.confirmation(self).deliver!
    end
    def send_acceptance_email_to_user
      DonationMailer.accepted(self).deliver!
    end
end
