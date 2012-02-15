class UsersController < ApplicationController
  def index
    # display num_to_show random members
    num_to_show = 5
    @users = User.membership_confirmed.shuffle[0..(num_to_show-1)]
  end

  def all
    @users = User.membership_confirmed.alphabetical
    @all = true
    render :index
  end

  def show
    @user = User.membership_confirmed.find(params[:id])
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
      thanks_str = "Thank you for your interest in 80,000 Hours, " << @user.name << ". \
        We've received your application and you'll hear from us soon. \
        In the meantime please confirm your account by following the link \
        in the email we sent to " << @user.email << "."
      redirect_to root_url, notice: thanks_str
    else
      render :new
    end
  end

  def email_list
    members = Member.confirmed.order("name ASC")
    @confirmed = ""
    members.each{|m| @confirmed << "\"" + m.name + "\" <" + m.email + ">, "};

    members = Member.unconfirmed.order("name ASC")
    @unconfirmed = ""
    members.each{|m| @unconfirmed << "\"" + m.name + "\" <" + m.email + ">, "};

    authorize! :read, Member
  end
end
