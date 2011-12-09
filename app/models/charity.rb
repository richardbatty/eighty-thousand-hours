class Charity < ActiveRecord::Base
  WEBSITE_REGEXP = /^https?:\/\/([^\s:@]+:[^\s:@]*@)?[-[[:alnum:]]]+(\.[-[[:alnum:]]]+)+\.?(:\d{1,5})?([\/?]\S*)?$/iux
  
  validates :name,    presence: true, uniqueness: true
  validates :website, presence: true, uniqueness: true, format: WEBSITE_REGEXP
  
  before_validation :format_website
  
  private
    def format_website
      website = "http://#{website}" if website !~ WEBSITE_REGEXP && "http://#{website}" =~ WEBSITE_REGEXP
    end
end
