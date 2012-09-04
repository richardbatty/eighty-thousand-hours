class ProfileOptionActivity < ActiveRecord::Base
  has_and_belongs_to_many :etkh_profiles
end
