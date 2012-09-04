class EtkhProfile < ActiveRecord::Base
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
                  :skills_knowledge_learn,
                  :causes_comment,
                  :profile_option_cause_ids,
                  :activities_comment,
                  :profile_option_activity_ids,
                  :donation_percentage,
                  :donation_percentage_optout

  # now we can access @etkh_profile.name etc.
  delegate :name, :name=, 
           :location, :location=,
           :to => :user

  scope :newest, order("created_at DESC")

  has_and_belongs_to_many :profile_option_causes
  has_and_belongs_to_many :profile_option_activities
end
