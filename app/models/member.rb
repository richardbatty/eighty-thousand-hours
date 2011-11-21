class Member < ActiveRecord::Base
  attr_accessible :background, :career_plans, :location, :user, :confirmed

  validates_presence_of :background, :career_plans

  # paperclip avatars on S3
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :s3_credentials => { :access_key_id     => ENV['S3_ACCESS'],
                                         :secret_access_key => ENV['S3_SECRET'] },
                    :path => ":attachment/:id/:style.:extension",
                    :bucket => 'eighty-thousand-hours',
                    :default_url => '/images/missing_:style.jpg'

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

