class MemberProfile < ActiveRecord::Base
  attr_accessible :background, :career_plans, :location, :pledge

  validates_presence_of :background, :career_plans
#  validates_acceptance_of :pledge

  # a User can have a MemberProfile
  belongs_to :user
end
