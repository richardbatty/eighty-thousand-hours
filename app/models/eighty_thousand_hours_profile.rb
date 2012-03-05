class EightyThousandHoursProfile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :background,
                  :career_plans,
                  :confirmed,
                  :inspiration,
                  :interesting_fact,
                  :occupation,
                  :organisation,
                  :organisation_role,
                  :doing_good_inspiring,
                  :doing_good_research,
                  :doing_good_philanthropy,
                  :doing_good_prophilanthropy,
                  :doing_good_innovating,
                  :doing_good_improving,
                  :public_profile,
                  :skills_knowledge_share,
                  :skills_knowledge_learn

  # now we can access @eighty_thousand_hours_profile.name etc.
  delegate :name, :name=, 
           :location, :location=,
           :to => :user
end
