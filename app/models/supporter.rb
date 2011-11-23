class Supporter < ActiveRecord::Base
  attr_accessible :name, :email, :dont_email_me, :anonymous

  validates_presence_of :name, :email
  validates_uniqueness_of :email, case_sensitive: false
end
