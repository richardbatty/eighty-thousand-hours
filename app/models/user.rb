class User < ActiveRecord::Base
  # add :omniauthable for facebook integration
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :bio, :pledge, :public
  
  validates_presence_of :name
  validates_uniqueness_of :name, :email, case_sensitive: false
  # +accept: true+ changes the accepted value from +'1'+ to +true+
  # value is automatically converted to +true+ by Rails
  # unless attribute is virtual
  validates_acceptance_of :pledge, accept: true
  validates_confirmation_of :password
end
