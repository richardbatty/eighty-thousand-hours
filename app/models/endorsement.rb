class Endorsement < ActiveRecord::Base
  scope :front_page, where( :front_page => true )
  scope :endorsement_page, where( :endorsement_page => true )
end
