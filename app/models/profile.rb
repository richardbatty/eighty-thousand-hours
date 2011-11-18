class Profile < ActiveRecord::Base
  attr_accessible :background, :career_plans, :location

  validates_presence_of :background, :career_plans

  def self.get_if_confirmed( id )
    profile = find( id, :include => :user )
    if profile[:confirmed]
      return profile
    else
      return nil
    end
  end

  def self.get_all_confirmed
    where( "confirmed = true", :include => :user )
  end

  # a User can have a Profile
  belongs_to :user
end
