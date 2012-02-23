class Member < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  attr_accessible :avatar,
                  :location,
                  :phone,
                  :on_team,
                  :team_role,
                  :team_role_id,
                  :external_twitter,
                  :external_facebook,
                  :external_linkedin,
                  :real_name,
                  :contacted_date,
                  :contacted_by,
                  :eighty_thousand_hours_application_attributes,
                  :eighty_thousand_hours_profile_attributes

  # a Member is always tied to a User 
  belongs_to :user

  # a Member can have a TeamRole (e.g. Events, Communications)
  belongs_to :team_role

  # a Member can create lots of donations
  has_many :donations

  # dependent means 80k application gets destroyed when member is destroyed
  has_one :eighty_thousand_hours_application, :dependent => :destroy
  accepts_nested_attributes_for :eighty_thousand_hours_application

  # dependent means 80k profile gets destroyed when member is destroyed
  has_one :eighty_thousand_hours_profile, :dependent => :destroy
  accepts_nested_attributes_for :eighty_thousand_hours_profile

  # now we can access @member.name, @member.email
  delegate :name, :name=, :email, :email=, :slug, :first_name, :to => :user
  delegate :public_profile, :to => :eighty_thousand_hours_application, :to => :eighty_thousand_hours_application

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
