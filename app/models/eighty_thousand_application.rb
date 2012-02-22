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

  validates_presence_of :occupation,          :message => "You must tell us what you currently do!"
  validates_presence_of :career_plans,        :message => "Please give some details about your career plans"
  validates_presence_of :donation_percentage, :message => "Estimate how much you intend to donate"
  validates_presence_of :average_income,      :message => "Estimate your average annual income"
  validates_presence_of :hic_activity_hours,  :message => "Estimate how much time you will donate to high impact activites"
  validates_presence_of :pledge,              :message => "You must agree to the 80,000 Hours declaration"
end
