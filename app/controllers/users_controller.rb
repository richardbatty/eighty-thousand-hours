class UsersController < ApplicationController
  load_and_authorize_resource :only => [:edit,:update,:destroy]

  def merge
    if session[:omniauth]
      # want the user to be redirected to account edit page on sign-in
      session[:user_return_to] = edit_registration_path :user
      render 'merge'
    else
      redirect_to new_user_registration_path
    end
  end

  def posts
    @user = User.find( params[:id] )
    if @user == current_user
      @posts = @user.blog_posts
    else
      @posts = @user.blog_posts.published
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
end
