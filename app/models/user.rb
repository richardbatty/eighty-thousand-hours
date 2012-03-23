class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  attr_accessible :name,
                  :email,
                  :password,
                  :password_confirmation,
                  :rememember_me,
                  :avatar,
                  :location,
                  :phone,
                  :on_team,
                  :team_role,
                  :team_role_id,
                  :external_website,
                  :external_twitter,
                  :external_facebook,
                  :external_linkedin,
                  :real_name,
                  :contacted_date,
                  :contacted_by,
                  :eighty_thousand_hours_application_attributes,
                  :eighty_thousand_hours_profile_attributes

  delegate :public_profile, :to => :eighty_thousand_hours_application

  # omniauth authentication
  has_many :authentications

  # dependent means 80k application gets destroyed when user is destroyed
  has_one :eighty_thousand_hours_application, :dependent => :destroy
  accepts_nested_attributes_for :eighty_thousand_hours_application

  # dependent means 80k profile gets destroyed when user is destroyed
  has_one :eighty_thousand_hours_profile, :dependent => :destroy
  accepts_nested_attributes_for :eighty_thousand_hours_profile

  # note that Devise handles the validation for email and password
  validates_presence_of   :name, :message => "You must tell us your name"

  # paperclip avatars on S3
  has_attached_file :avatar, {
                      :styles => { :medium => "200x200", :small => "100x100>", :thumb => "64x64" },
                      :default_url => "/assets/profiles/avatar_default_200x200.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  validates_attachment_size :avatar, :less_than => 2.megabytes,
                            :unless => Proc.new {|m| m[:image].nil?}
  validates_attachment_content_type :avater, :content_type=>['image/jpeg', 'image/png', 'image/gif'],
                                    :unless => Proc.new {|m| m[:image].nil?}


  # e.g. Admin, BlogAdmin, WebAdmin
  has_and_belongs_to_many :roles
  
  # a User can have a TeamRole (e.g. Events, Communications)
  belongs_to :team_role

  # a User can create lots of donations
  has_many :donations

  # a User can vote on lots of posts
  has_many :votes

  scope :alphabetical, order("name ASC")
  scope :newest, order("created_at DESC")
  
  def has_role?(symbol)
    roles.map {|r| r.name.underscore.to_sym }
         .include? symbol.to_s.underscore.to_sym
  end
  
  def first_name
    name.split.first
  end

  def last_name
    name.split.last
  end

  #useful nested scopes
  scope :confirmed,   where(:confirmed => true)
  scope :unconfirmed, where(:confirmed => false)
  scope :contacted,   where({:confirmed => false}).where("contacted_date IS NOT NULL")
  scope :not_contacted, where({:confirmed => false, :contacted_date => nil})
  scope :on_team, confirmed.where(:on_team => true).joins(:team_role)

  def external_links?
    external_website? || external_twitter? || external_linkedin? || external_facebook?
  end
  
  def self.with_team_role(role)
    on_team.where(team_roles: {name: role.to_s.humanize.titleize})
  end

  # for active admin dashboard
  def admin_permalink
    admin_user_path(self)
  end

  def send_apply_email_to_80k_team
    UserMailer.apply(self).deliver!
  end

  def total_confirmed_donations
    donations.confirmed.sum(:amount)
  end
end
