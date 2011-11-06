class User < ActiveRecord::Base
  # add :omniauthable for facebook integration
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
end
