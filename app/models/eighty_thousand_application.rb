class EightyThousandApplication < ActiveRecord::Base
  belongs_to :member

  attr_accessible :occupation,
                  :career_plans,
                  :reasons_for_joining,
                  :spoken_to_existing_member,
                  :doing_good_inspiring,
                  :doing_good_research,
                  :doing_good_prophil,
                  :doing_good_innovating,
                  :doing_good_improving,
                  :donation_percentage,
                  :donation_percentage_comment,
                  :average_income,
                  :average_income_comment,
                  :hic_activity_hours,
                  :hic_activity_hours_comment,
                  :causes_givewell,
                  :causes_gwwc,
                  :causes_international,
                  :causes_xrisk,
                  :causes_meta,
                  :causes_domestic,
                  :causes_animal,
                  :causes_political,
                  :causes_comment,
                  :pledge

  validates_presence_of :pledge, :message => "You must agree to the 80,000 Hours declaration"
end
