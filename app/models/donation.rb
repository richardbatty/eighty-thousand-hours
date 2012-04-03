class Donation < ActiveRecord::Base
  before_save :ensure_date_filled

  validates :user_id, presence: true
  validates :cause_id, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.01 }
  validates :currency, :inclusion => { :in => %w(GBP USD),
              :message => "Currency must be GBP or USD (%{value} given)" }

  belongs_to :cause
  belongs_to :user
  
  after_create :send_confirmation_email_to_user

  attr_accessible :user_id, :cause_id, :amount, :receipt, :public, :public_amount, :date, :currency
  
  # paperclip gem for receipt uploads to s3
  has_attached_file :receipt,
                    :storage => :s3, 
                    :s3_credentials => { :access_key_id     => ENV['S3_ACCESS'],
                                         :secret_access_key => ENV['S3_SECRET'],
                                         :bucket            => ENV['S3_BUCKET'] },
                    :path => "/donations/:id/:filename"

  scope :confirmed, where(:confirmed => true).order("date DESC")
  scope :is_public, where(:public => true)
  scope :is_public_amount, is_public.where(:public_amount => true)

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

    def ensure_date_filled
      if self.date.nil?
        self.date = self.created_at.to_date
      end
    end
end
