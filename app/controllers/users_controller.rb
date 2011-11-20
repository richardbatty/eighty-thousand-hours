class UsersController < ApplicationController
  #TODO all of these should only be accessible by Admins
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id( params[:id] )
  end

  def admin
    @users = User.all
  end
end
