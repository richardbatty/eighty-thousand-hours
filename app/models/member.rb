class Member < ActiveRecord::Base
  attr_accessible :background, :career_plans, :location,
                  :confirmed, :avatar, :inspiration, :interesting_fact,
                  :location, :organisation_role, :phone, :pledge,
                  :on_team, :team_role, :team_role_id,
                  :apply_occupation, :apply_reasons_for_joining,
                  :apply_heard_about_us, :apply_spoken_to_existing_member, :apply_career_plans,
                  :doing_good_influencing, :doing_good_research, :doing_good_prophil,
                  :external_twitter, :external_facebook, :external_linkedin,
                  :occupation, :organisation, :public_profile

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
  validates_presence_of :apply_reasons_for_joining,       :message => "Tell us why you'd like to join 80,000 Hours"
  validates_presence_of :apply_heard_about_us,            :message => "We'd like to know how you heard about us"
  validates_presence_of :apply_spoken_to_existing_member, :message => "Do you know an existing member? 'No' is ok!"
  validates_acceptance_of :pledge,                        :message => "You must accept the 80,000 hours pledge"

  # a Member is always tied to a User 
  belongs_to :user

  # a Member can have a TeamRole (e.g. Events, Communications)
  belongs_to :team_role

  # now we can access @member.name, @member.email
  delegate :name, :name=, :email, :email=, :slug, :to => :user

  #useful nested scopes
  scope :with_user, joins(:user).includes(:user)
  scope :confirmed,   with_user.where(:confirmed => true)
  scope :unconfirmed, with_user.where(:confirmed => false)
  scope :on_team, confirmed.where(:on_team => true).joins(:team_role)
  
  def self.with_team_role(role)
    on_team.where(team_roles: {name: role.to_s.humanize.titleize})
  end
end
