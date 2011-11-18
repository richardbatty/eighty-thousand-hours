class Profile < ActiveRecord::Base
  attr_accessible :background, :career_plans, :location, :pledge

  validates_presence_of :background, :career_plans
#  validates_acceptance_of :pledge

  # a User can have a Profile
  belongs_to :user
end
