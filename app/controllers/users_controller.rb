class UsersController < ApplicationController

  #TODO this should only be accessible by Admins

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id( params[:id] )
  end
end
