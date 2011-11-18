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
           redirect_to(@profile, :notice => 'Profile was successfully created.')
           return
        end
      end
    end

    # something went wrong so we go back to new page
    # best destroy the user as name/email may change now
    @user.destroy
    @profile.destroy
    render :action => "new"
  end
end
