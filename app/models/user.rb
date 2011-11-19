class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_one :member
  accepts_nested_attributes_for :member

  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :member_attributes

  validates_presence_of :name
  validates_uniqueness_of :name, :email, case_sensitive: false
  validates_confirmation_of :password

  has_and_belongs_to_many :roles


  def self.get_if_confirmed( id )
    profile = find( id, :include => :user )
    if profile[:confirmed]
      return profile
    else
      return nil
    end
  end
end
