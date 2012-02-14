# == Schema Information
#
# Table name: supporters
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  email         :string(255)
#  dont_email_me :boolean
#  anonymous     :boolean
#  created_at    :datetime
#  updated_at    :datetime
#

class Supporter < ActiveRecord::Base
  attr_accessible :name, :email, :dont_email_me, :anonymous

  validates_presence_of :name, :email
  validates_uniqueness_of :email, case_sensitive: false
end
