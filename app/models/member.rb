class Member < ActiveRecord::Base
  before_create :seed_profile_from_apply_fields

  attr_accessible :background, :career_plans, :location,
                  :confirmed, :avatar, :inspiration, :interesting_fact,
                  :location, :organisation_role, :phone, :pledge,
                  :show_name, :show_info, :on_team, :team_role, :team_role_id,
                  :apply_occupation, :apply_reasons_for_joining,
                  :apply_heard_about_us, :apply_spoken_to_existing_member, :apply_career_plans,
                  :doing_good_influencing, :doing_good_research, :doing_good_prophil,
                  :external_twitter, :external_facebook, :external_linkedin,
                  :occupation, :organisation

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
  validates_presence_of :apply_occupation,
                        :apply_career_plans,
                        :apply_reasons_for_joining,
                        :apply_heard_about_us,
                        :apply_spoken_to_existing_member

  validates_acceptance_of :pledge

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

  private
    def seed_profile_from_apply_fields
      self.occupation = self.apply_occupation
      self.career_plans = self.apply_career_plans
    end
end
