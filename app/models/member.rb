class Member < ActiveRecord::Base
  attr_accessible :background, :career_plans, :location, :user, :confirmed, :avatar

  validates_presence_of :background, :career_plans

  # paperclip avatars on S3
  has_attached_file :avatar, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/profiles/:style/:id/:filename"

  # a Member is always tied to a User 
  belongs_to :user

  # now we can access @member.name, @member.email
  delegate :name, :name=, :email, :email=, :to => :user

  def self.all_confirmed
    all( :include => :user,
         :conditions => "confirmed IS true" );
  end

  def self.find_by_slug( name )
    @user = User.find_by_slug( name )
    if @user
      return @member = @user.member
    else
      #@error = "We couldn't find a member called '#{params[:name]}', sorry!" 
      return nil
    end
  end
end

