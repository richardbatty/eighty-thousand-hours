class UsersController < ApplicationController
  #TODO all of these should only be accessible by Admins
  def index
    @users = User.with_member
  end

  def show
    @user = User.find( params[:id] )
  end

  def destroy
    user = User.find( params[:id] )
    name = user.name
    if user.destroy
      flash[:notice] = "Deleted #{name}"
    else
      flash[:error] = "Failed to delete #{name}!"
    end
    redirect_to users_path
  end

  def confirm_member
    user = User.find( params[:id] )
    user.member.confirmed = true
  end
end
