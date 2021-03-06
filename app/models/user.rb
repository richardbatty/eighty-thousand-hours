class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  # votes are independent from users so destroy associated votes here
  before_destroy { |user| Vote.destroy_all "user_id = #{user.id}" }

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
                  :etkh_profile_attributes

  delegate :public_profile, :to => :etkh_profile

  # omniauth authentication
  has_many :authentications, :dependent => :destroy

  # comments on posts
  has_many :comments, :dependent => :destroy

  # dependent means 80k profile gets destroyed when user is destroyed
  has_one :etkh_profile, :dependent => :destroy
  accepts_nested_attributes_for :etkh_profile
  before_create :build_default_profile

  # a user can write many blog posts
  has_many :blog_posts

  # a user can write many discussion posts
  has_many :discussion_posts

  # note that Devise handles the validation for email and password
  validates_presence_of   :name, :message => "You must tell us your name"

  # paperclip avatars on S3
  has_attached_file :avatar, {
                      :styles => { :medium => "200x200", :small => "100x100#", :thumb => "64x64#" },
                      :default_url => "/assets/profiles/avatar_default_200x200.png",
                      :path => "/avatars/:style/:id/:filename"
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

  scope :etkh_members, joins(:etkh_profile)
  scope :non_etkh_members, lambda { includes(:etkh_profile).where('etkh_profiles.id is null') }

  def eighty_thousand_hours_member?
    self.etkh_profile
  end

  def first_name
    name.split.first
  end

  def last_name
    name.split.last
  end

  def external_links?
    external_website? || external_twitter? || external_linkedin? || external_facebook?
  end
  
  def self.with_team_role(role)
    where(on_team: true).find_all{|u| (u.team_role.name == role)}
  end

  # for active admin dashboard
  def admin_permalink
    admin_user_path(self)
  end

  def total_confirmed_donations
    donations.confirmed.sum(:amount)
  end


  private
  def build_default_profile
    # build default profile instance. Will use default params.
    # The foreign key to the owning User model is set automatically
    build_etkh_profile
    true # Always return true in callbacks as the normal 'continue' state
         # Assumes that the default_profile can **always** be created.
         # or
         # Check the validation of the profile. If it is not valid, then
         # return false from the callback. Best to use a before_validation
         # if doing this. View code should check the errors of the child.
         # Or add the child's errors to the User model's error array of the :base
         # error item
  end
end
