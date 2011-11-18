class ProfilesController < ApplicationController
  def index
    @profiles = Profile.find( :all, :include => :user )
  end

  def show
    @profile = Profile.find( params[:id], :include => :user )
  end

  def new
    @profile = Profile.new
    @user = User.new
    @profile.user = @user;
  end
end
