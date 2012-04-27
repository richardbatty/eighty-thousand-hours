class Donation < ActiveRecord::Base
  before_save :ensure_date_filled

  validates :user_id, presence: true
  validates :cause_id, presence: true
  validates :amount_cents, numericality: { greater_than_or_equal_to: 1 }
  validates :currency, :inclusion => { :in => %w(GBP USD EUR),
            :message => "Currency must be GBP, USD, or EUR (%{value} given)" }

  monetize :amount_cents

  belongs_to :cause
  belongs_to :user

  after_create :send_confirmation_email_to_user

  attr_accessible :user_id,
                  :cause_id,
                  :amount,
                  :amount_cents,
                  :receipt,
                  :public,
                  :public_amount,
                  :date,
                  :currency,
                  :confirmed
  
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

  def self.total( currency = "GBP", with_symbol = false )
    donations = Donation.confirmed.all
    if donations.any?
      total = Donation.confirmed.all.map{|d| d.amount.exchange_to(currency).dollars}.sum
      if with_symbol
        "#{ActionController::Base.helpers.number_to_currency(total, unit: "&pound;", precision: 0)}"
      else
        sprintf '%.0f', total
      end
    end
  end

  def self.target
    "&pound;80,000".html_safe
  end

  def self.target_percentage
    (100 * Donation.total(:GBP,false).to_f / 80000.0).to_i
  end

  def confirm!
    self.confirmed = true
    self.save
    send_acceptance_email_to_user
  end

  def with_currency
    "#{amount.currency.symbol}#{ "%g" % amount.dollars }"
  end

  def with_currency_word
    "#{amount.currency.iso_code} #{ "%g" % amount.dollars }"
  end

  private
    def send_confirmation_email_to_user
      if self.confirmed
        send_acceptance_email_to_user
      else
        DonationMailer.confirmation(self).deliver!
      end
    end
    def send_acceptance_email_to_user
      DonationMailer.accepted(self).deliver!
    end

    def ensure_date_filled
      if self.date.blank?
        self.date = DateTime.now
      end
    end
end
