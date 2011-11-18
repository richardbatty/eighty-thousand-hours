class ProfilesController < ApplicationController
  def index
    @profiles = Profile.find( :all, :include => :user )
  end

  def show
    @profile = Profile.find( params[:id], :include => :user )
  end

  def new
    @profile = Profile.new
    @user    = User.new
  end

  def create
    @profile = Profile.new(params[:profile])
    @user =    User.new(params[:user])

    # eager evaluation so both @user.errors and @profile.errors
    # get filled if don't pass validations
    if @user.valid? & @profile.valid?
      if @user.save
        @profile.user = @user;
        if @profile.save 
          thanks_str = "Thanks " << @user[:name] << ", we've received your application and will be in touch shortly. The email address we have for you is " << @user[:email] << ", if this is incorrect then please contact info@highimpactcareers.org as soon as possible!";
           redirect_to('/', :notice => thanks_str)
           return
        end
      end
    end

    # something went wrong so we go back to new page
    # best destroy the user as name/email may change now
    @user.destroy
    @profile.destroy
    render :new
  end
end
