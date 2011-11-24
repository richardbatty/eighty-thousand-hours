class Member < ActiveRecord::Base
  attr_accessible :background, :career_plans, :location,
                  :confirmed, :avatar, :inspiration, :interesting_fact,
                  :location, :organisation_role, :phone, :pledge,
                  :show_name, :show_info, :on_team, :team_role_id

  # paperclip avatars on S3
  has_attached_file :avatar, 
                    :styles => { :medium => "200x200", :small => "100x100>", :thumb => "64x64" },
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS, # set in initializers/s3.rb
                    :path => "/profiles/:style/:id/:filename",
                    :default_url => "/assets/profiles/avatar_default_96x96.png"

  validates_attachment_size :avatar, :less_than => 2.megabytes,
                            :unless => Proc.new {|m| m[:image].nil?}
  validates_attachment_content_type :avater, :content_type=>['image/jpeg', 'image/png', 'image/gif'],
                                    :unless => Proc.new {|m| m[:image].nil?}
  
  validates_presence_of :background, :career_plans
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
  scope :on_team, confirmed.where(:on_team => true)
end
