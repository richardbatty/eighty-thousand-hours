class Charity < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  WEBSITE_REGEXP = /^https?:\/\/([^\s:@]+:[^\s:@]*@)?[-[[:alnum:]]]+(\.[-[[:alnum:]]]+)+\.?(:\d{1,5})?([\/?]\S*)?$/iux
  
  validates_presence_of :name, :message => "Please enter a charity name"
  validates_uniqueness_of :name, :message => "Charity already exists!"
  validates_presence_of :website, :format => WEBSITE_REGEXP, :message => "Please enter a valid URL"
  validates_presence_of :description, :message => "Please describe the work this charity does (can be brief)"
  
  before_validation :format_website

  attr_accessible :name, :website, :description
  
  has_many :donations

  def total_confirmed_donations
    donations.confirmed.sum(:amount)
  end
  
  private
    def format_website
      website = "http://#{website}" if website !~ WEBSITE_REGEXP && "http://#{website}" =~ WEBSITE_REGEXP
    end
end
