class Member < ActiveRecord::Base
  attr_accessible :background, :career_plans, :location, :user, :confirmed

  validates_presence_of :background, :career_plans

  # a Member is always tied to a User 
  belongs_to :user

  # now we can access @member.name, @member.email
  delegate :name, :name=, :email, :email=, :to => :user
end

