class Endorsement < ActiveRecord::Base
  scope :endorsement_page, where( :endorsement_page => true )

  def self.front_page
    # an endorsement with a higher weight is more likely
    # to appear on the front page...
    where(front_page: true).order('random()*weight').last
  end
end
