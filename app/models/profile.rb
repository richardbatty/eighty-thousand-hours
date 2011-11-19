class Profile < ActiveRecord::Base
  attr_accessible :background, :career_plans, :location, :user

  validates_presence_of :background, :career_plans

  # a Profile is always tied to a User 
  belongs_to :user
end

