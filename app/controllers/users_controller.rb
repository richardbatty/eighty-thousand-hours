class UsersController < ApplicationController
  #TODO all of these should only be accessible by Admins
  def index
    @users = User.membership_confirmed.shuffle
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

  def new
    @user   = User.new
    @member = @user.build_member
  end
  
  def create
    @user =    User.new(params[:user])
    @member = @user.build_member(params[:member])

    # eager evaluation so both @user.errors and @member.errors
    # get filled if don't pass validations
    if @user.valid? & @member.valid?
      if @user.save
        @member.user = @user;
        if @member.save 
          thanks_str = "Thanks " << @user[:name] << ", we've received your application and will be in touch shortly. In the meantime please confirm your account by following the link in the email we sent to " << @user[:email] << "."; 
           redirect_to('/', :notice => thanks_str)
           return
        end
      end
    end

    # something went wrong so we go back to new page
    # best destroy the user as name/email may change now
    @user.destroy
    @member.destroy
    render :new
  end
end

