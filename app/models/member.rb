class Member < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  attr_accessible :background, :career_plans, :location,
                  :confirmed, :avatar, :inspiration, :interesting_fact,
                  :location, :organisation_role, :phone, :pledge,
                  :on_team, :team_role, :team_role_id,
                  :doing_good_inspiring, :doing_good_research, :doing_good_prophil,
                  :doing_good_innovating, :doing_good_improving,
                  :external_twitter, :external_facebook, :external_linkedin,
                  :occupation, :organisation, :public_profile,
                  :pseudonym, :use_pseudonym,
                  :real_name, :contacted_date, :contacted_by,
                  :eighty_thousand_application_attributes

  # a Member is always tied to a User 
  belongs_to :user

  # a Member can have a TeamRole (e.g. Events, Communications)
  belongs_to :team_role

  # a Member can create lots of donations
  has_many :donations

  # dependent means application_for_80k gets destroyed when member is destroyed
  has_one :eighty_thousand_application, :dependent => :destroy
  accepts_nested_attributes_for :eighty_thousand_application

  # now we can access @member.name, @member.email
  delegate :name, :name=, :email, :email=, :slug, :first_name, :to => :user

  # paperclip avatars on S3
  has_attached_file :avatar, {
                      :styles => { :medium => "200x200", :small => "100x100>", :thumb => "64x64" },
                      :default_url => "/assets/profiles/avatar_default_96x96.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  validates_attachment_size :avatar, :less_than => 2.megabytes,
                            :unless => Proc.new {|m| m[:image].nil?}
  validates_attachment_content_type :avater, :content_type=>['image/jpeg', 'image/png', 'image/gif'],
                                    :unless => Proc.new {|m| m[:image].nil?}

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
