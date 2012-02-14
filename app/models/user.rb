# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  slug                   :string(255)
#

class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  # dependent means member gets destroyed when user is destroyed
  has_one :member, :dependent => :destroy
  accepts_nested_attributes_for :member
  
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :member_attributes

  # note that Devise handles the validation for email and password
  validates_presence_of   :name,                         :message => "You must tell us your name"
  validates_uniqueness_of :name,  case_sensitive: false, :message => "That name is already taken!"

  has_and_belongs_to_many :roles
  
  scope :with_member, joins(:member).includes(:member)
  scope :membership_confirmed, with_member.where(:members => {:confirmed => true, :public_profile => true})
  scope :alphabetical, order("name ASC")
  
  def has_role?(symbol)
    roles.map {|r| r.name.underscore.to_sym }
         .include? symbol.to_s.underscore.to_sym
  end
  
  def first_name
    name.split.first
  end
end
