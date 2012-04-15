class Endorsement < ActiveRecord::Base
  scope :endorsement_page, where( :endorsement_page => true )

  def self.get_header_endorsement
    # an endorsement with a higher weight is more likely
    # to appear in the header...
    where(header: true).order('random()/weight').first
  end

  before_save :ensure_positive_weight

  private
  def ensure_positive_weight
    self.weight = 1 if (self.weight < 1)
  end
end
