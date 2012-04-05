class UsersController < ApplicationController
  load_and_authorize_resource :only => [:edit,:update,:destroy]

  def index
    get_grouped_users

    @menu_root = "Our community"
    @menu_current = "Our members"
  end

  def merge
    # want the user to be redirected to account edit page on sign-in
    session[:user_return_to] = edit_registration_path :user
  end

  def get_grouped_users
    @users = User.confirmed.alphabetical
    @grouped_users = @users.group_by{|user| user.name[0].upcase}
    @newest_users = User.confirmed.newest.limit(8)
  end

  def posts
    @user = User.find( params[:id] )
    if @user == current_user
      @posts = @user.posts
    else
      @posts = @user.posts.published
    end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @donations = @user.donations.confirmed

    @menu_root = "Our community"
    @menu_current = "Our members"
  end

  def destroy
    user = User.find( params[:id] )
    name = user.name
    if user.destroy
      flash[:"alert-success"] = "Deleted #{name}"
    else
      flash[:"alert-error"] = "Failed to delete #{name}!"
    end
    redirect_to users_path
  end

  def edit
    @user = current_user
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
  

  def email_list
    members = User.confirmed.order("name ASC")
    @confirmed = ""
    members.each{|m| @confirmed << "\"" + m.name + "\" <" + m.email + ">, "};

    members = User.unconfirmed.order("name ASC")
    @unconfirmed = ""
    members.each{|m| @unconfirmed << "\"" + m.name + "\" <" + m.email + ">, "};

    authorize! :read, User
  end
end
