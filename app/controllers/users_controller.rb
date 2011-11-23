class UsersController < ApplicationController
  def index
    @users = User.membership_confirmed.shuffle
  end

  def show
    @user = User.with_member.find(params[:id])
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

  def new
    @user = User.new
    @user.build_member
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      # redirects should be full url for browser compatibility
      thanks_str = "Thanks " << @user.name << 
        ", we've received your application and will be in touch shortly. \
        In the meantime please confirm your account by following the link \
        in the email we sent to " << @user.email << "."
      redirect_to root_url, notice: thanks_str
    else
      render :new
    end
  end
end
