class Comment < ActiveRecord::Base
  validates_presence_of :body,    message: "can't be blank"
  validates_presence_of :post_id

  attr_accessor :email_confirmation

  before_save :either_user_or_email
  before_validation :check_honeypot

  belongs_to :user
  belongs_to :post

  def get_name
    user ? user.name : name
  end

  private
  def check_honeypot
    email_confirmation.blank?
  end

  def either_user_or_email
    result = true
    if self.user.nil?
      if self.name.blank?
        errors.add(:name, "can't be blank" )
        result = false
      end
      if self.email.blank?
        errors.add(:email, "can't be blank" )
        result = false
      end
    end
    result
  end
end
