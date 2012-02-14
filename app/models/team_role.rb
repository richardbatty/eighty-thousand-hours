# == Schema Information
#
# Table name: team_roles
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TeamRole < ActiveRecord::Base
  has_many :members
end
