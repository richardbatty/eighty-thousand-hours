# == Schema Information
#
# Table name: charities
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  website    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Charity < ActiveRecord::Base
  WEBSITE_REGEXP = /^https?:\/\/([^\s:@]+:[^\s:@]*@)?[-[[:alnum:]]]+(\.[-[[:alnum:]]]+)+\.?(:\d{1,5})?([\/?]\S*)?$/iux
  
  validates :name, :website, presence: true, uniqueness: true
  validates :website, format: WEBSITE_REGEXP
  
  before_validation :format_website
  
  has_many :donations
  
  private
    def format_website
      website = "http://#{website}" if website !~ WEBSITE_REGEXP && "http://#{website}" =~ WEBSITE_REGEXP
    end
end
