class Member < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  # for versioning with paper_trail
  has_paper_trail

  attr_accessible :background, :career_plans, :location,
                  :confirmed, :avatar, :inspiration, :interesting_fact,
                  :location, :organisation_role, :phone, :pledge,
                  :on_team, :team_role, :team_role_id,
                  :apply_occupation, :apply_reasons_for_joining,
                  :apply_heard_about_us, :apply_spoken_to_existing_member, :apply_career_plans,
                  :doing_good_inspiring, :doing_good_research, :doing_good_prophil,
                  :doing_good_innovating, :doing_good_improving,
                  :external_twitter, :external_facebook, :external_linkedin,
                  :occupation, :organisation, :public_profile,
                  :pseudonym, :use_pseudonym,
                  :donation_percentage,
                  :donation_average_income,
                  :donation_hic_activity_hours,
                  :donation_percentage_comment,
                  :donation_average_income_comment,
                  :donation_hic_activity_hours_comment,
                  :donation_causes_givewell,
                  :donation_causes_gwwc,
                  :donation_causes_xrisk,
                  :donation_causes_meta,
                  :donation_causes_animal,
                  :donation_causes_political,
                  :donation_causes_international,
                  :donation_causes_domestic,
                  :donation_causes_comment,
                  :parallel_universe_donation_percentage,
                  :parallel_universe_donation_average_income,
                  :parallel_universe_donation_hic_activity_hours,
                  :parallel_universe_occupation,
                  :real_name, :contacted_date, :contacted_by


  # paperclip avatars on S3
  has_attached_file :avatar, {
                      :styles => { :medium => "200x200", :small => "100x100>", :thumb => "64x64" },
                      :default_url => "/assets/profiles/avatar_default_96x96.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  validates_attachment_size :avatar, :less_than => 2.megabytes,
                            :unless => Proc.new {|m| m[:image].nil?}
  validates_attachment_content_type :avater, :content_type=>['image/jpeg', 'image/png', 'image/gif'],
                                    :unless => Proc.new {|m| m[:image].nil?}
  
  # all application fields are mandatory
  validates_presence_of :apply_occupation,                :message => "You must tell us what you currently do!"
  validates_presence_of :apply_career_plans,              :message => "Please give some details about your career plans"
  #validates_presence_of :apply_reasons_for_joining,       :message => "Tell us why you'd like to join 80,000 Hours"
  #validates_presence_of :apply_heard_about_us,            :message => "We'd like to know how you heard about us"
  #validates_presence_of :apply_spoken_to_existing_member, :message => "Do you know an existing member? 'No' is ok!"
  validates_presence_of :donation_percentage,             :message => "Estimate how much you intend to donate"
  validates_presence_of :donation_average_income,         :message => "Estimate your average annual income"
  validates_presence_of :donation_hic_activity_hours,     :message => "Estimate how much time you will donate to high impact activites"
  #validates_presence_of :parallel_universe_donation_percentage,             :message => "Estimate how much money you would have donated if you hadn't heard about 80,000 Hours"
  #validates_presence_of :parallel_universe_donation_average_income,         :message => "Estimate how much you would have earned if you hadn't heard about 80,000 Hours"
  #validates_presence_of :parallel_universe_donation_hic_activity_hours,     :message => "Estimate how much time you would have donated if you hadn't heard about 80,000 Hours"
  #validates_presence_of :parallel_universe_occupation,                      :message => "Tell us how your career plans have changed after finding out about 80,000 Hours"
  validates_acceptance_of :pledge,                        :message => "You must agree to the 80,000 Hours declaration"

  # a Member is always tied to a User 
  belongs_to :user

  # a Member can have a TeamRole (e.g. Events, Communications)
  belongs_to :team_role
  
  has_many :donations
  
  # now we can access @member.name, @member.email
  delegate :name, :name=, :email, :email=, :slug, :first_name, :to => :user

  #useful nested scopes
  scope :with_user, joins(:user).includes(:user)
  scope :confirmed,   with_user.where(:confirmed => true)
  scope :unconfirmed, with_user.where(:confirmed => false)
  scope :contacted,   with_user.where({:confirmed => false}).where("contacted_date IS NOT NULL")
  scope :not_contacted, with_user.where({:confirmed => false, :contacted_date => nil})
  scope :on_team, confirmed.where(:on_team => true).joins(:team_role)
  
  def self.with_team_role(role)
    on_team.where(team_roles: {name: role.to_s.humanize.titleize})
  end

  # for active admin dashboard
  def admin_permalink
    admin_member_path(self)
  end
end
