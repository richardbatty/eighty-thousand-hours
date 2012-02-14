# == Schema Information
#
# Table name: endorsements
#
#  id         :integer         not null, primary key
#  author     :string(255)
#  position   :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Endorsement < ActiveRecord::Base
end
