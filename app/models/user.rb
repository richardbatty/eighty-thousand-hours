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
  scope :membership_confirmed, with_member.where(:members => {:confirmed => true})
  scope :alphabetical, order("name ASC")
  
  def has_role?(symbol)
    roles.map {|r| r.name.downcase.to_sym }
         .include? symbol.downcase.to_sym
  end
end
