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

  validates_presence_of :name
  validates_uniqueness_of :name, :email, case_sensitive: false
  validates_confirmation_of :password

  has_and_belongs_to_many :roles
  
  def has_role?(symbol)
    roles.map {|r| r.name.downcase.to_sym }
         .include? symbol.downcase.to_sym
  end
end
