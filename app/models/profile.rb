class Profile < ActiveRecord::Base
  attr_accessible :background, :career_plans, :location

  validates_presence_of :background, :career_plans

  # a User can have a Profile
  belongs_to :user
end
