class Member < ActiveRecord::Base
  attr_accessible :background, :career_plans, :location, :user, :confirmed, :avatar

  validates_presence_of :background, :career_plans

  # paperclip avatars on S3
  has_attached_file :avatar, 
                    :styles => { :large => "300x300", :medium => "200x200>", :small => "96x96", :thumb => "64x64" },
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS, # set in initializers/s3.rb
                    :path => "/profiles/:style/:id/:filename",
                    :default_url => "/assets/profiles/avatar_default_96x96.png"

  validates_attachment_size :avatar, :less_than => 2.megabytes,
                            :unless => Proc.new {|m| m[:image].nil?}
  validates_attachment_content_type :avater, :content_type=>['image/jpeg', 'image/png', 'image/gif'],
                                    :unless => Proc.new {|m| m[:image].nil?}

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

