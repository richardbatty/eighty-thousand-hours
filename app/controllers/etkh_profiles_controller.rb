class EtkhProfilesController < ApplicationController
  load_and_authorize_resource :only => [:new,:create,:edit,:update,:destroy]

  def index
    get_grouped_profiles

    @menu_root = "Our community"
    @menu_current = "Our members"
  end

  def get_grouped_profiles
    @profiles = EtkhProfile.all.to_a.sort_by{|p| p.user.name[0].upcase }
    @grouped_profiles = @profiles.group_by{ |profile| profile.user.name[0].upcase }
    @newest_profiles = EtkhProfile.newest.limit(8)
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @donations = @user.donations.confirmed
    @profile = @user.etkh_profile

    @menu_root = "Our community"
    @menu_current = "Our members"
  end

  def destroy
    profile = EtkhProfiles.find( params[:id] )
    if profile.destroy
      flash[:"alert-success"] = "Deleted profile"
    else
      flash[:"alert-error"] = "Failed to delete profile!"
    end
    redirect_to users_path
  end

  def edit
    @etkh_profile = current_user.etkh_profile
  end

  def update
    if current_user.update_attributes(params[:user])
      flash[:"alert-success"] = "Your profile was successfully updated."
      redirect_to( etkh_profile_path( current_user ) )
    else
      render :action => "edit"
    end
  end

  def search
    @user = User.find_by_name(params[:name])
    if @user
      redirect_to etkh_profile_path(@user)
    else
      flash[:"alert-error"] = "Couldn't find #{params[:name]}!"
      redirect_to :action => :index
    end
  end

  def email_list
    @members = EtkhProfile.order("created_at ASC")

    authorize! :read, EtkhProfile
  end
end
