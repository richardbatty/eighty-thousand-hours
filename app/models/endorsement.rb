class Endorsement < ActiveRecord::Base
  scope :endorsement_page, where( :endorsement_page => true )

  def self.get_header_endorsement
    # an endorsement with a higher weight is more likely
    # to appear in the header...
    where(header: true).order('random()*weight').last
  end
end
