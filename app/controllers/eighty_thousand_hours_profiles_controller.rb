class EightyThousandHoursProfilesController < ApplicationController
  load_and_authorize_resource :only => [:new,:create,:edit,:update,:destroy]

  def index
    get_grouped_users

    @menu_root = "Our community"
    @menu_current = "Our members"
  end

  def get_grouped_users
    @users = User.eighty_thousand_hours_members.alphabetical
    @grouped_users = @users.group_by{|user| user.name[0].upcase}
    @newest_users = User.eighty_thousand_hours_members.newest.limit(8)
  end

  def show
    @user = User.eighty_thousand_hours_members.find(params[:id])
    @title = @user.name
    @donations = @user.donations.confirmed

    @menu_root = "Our community"
    @menu_current = "Our members"
  end

  def destroy
    profile = EightyThousandHoursProfiles.find( params[:id] )
    if profile.destroy
      flash[:"alert-success"] = "Deleted profile"
    else
      flash[:"alert-error"] = "Failed to delete profile!"
    end
    redirect_to users_path
  end

  def edit
    @eighty_thousand_hours_profile = current_user.eighty_thousand_hours_profile
  end

  def update
    if current_user.update_attributes(params[:user])
      flash[:"alert-success"] = "Your profile was successfully updated"
      redirect_to(current_user)
    else
      render :action => "edit"
    end
  end

  def search
    @user = User.find_by_name(params[:name])
    if @user
      redirect_to user_path(@user)
    else
      flash[:"alert-error"] = "Couldn't find #{params[:name]}!"
      redirect_to :action => :index
    end
  end
end
