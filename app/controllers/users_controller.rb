class UsersController < ApplicationController
  load_and_authorize_resource :only => [:edit,:update,:destroy]

  def index
    get_grouped_users

    @menu_root = "Our community"
    @menu_current = "Our members"
  end

  def get_grouped_users
    @users = User.confirmed.alphabetical
    @grouped_users = @users.group_by{|user| user.name[0].upcase}
    @newest_users = User.confirmed.newest.limit(8)
  end

  def show
    @user = User.confirmed.find(params[:id])
    @title = @user.name

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

  def new
    @user = User.new
    @user.build_eighty_thousand_hours_application
    @user.build_eighty_thousand_hours_profile

    @menu_root = "Membership"
    @menu_current = "Join now"
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
  
  def create
    @user = User.new(params[:user])

    # should we be building this now, here? or after we confirm?
    @user.build_eighty_thousand_hours_profile
    
    if @user.save
      # fire off an email informing 80k team (join@80k..)
      @user.send_apply_email_to_80k_team 

      # add name to 'show your support'
      @supporter = Supporter.new(:name => @user.name, :email => @user.email)
      @supporter.save

      # redirects should be full url for browser compatibility
      thanks_str = "Thank you for your interest in 80,000 Hours, " << @user.name << ". \
        We've received your application and you'll hear from us soon. \
        In the meantime please confirm your account by following the link \
        in the email we sent to " << @user.email << "."
      flash[:"alert-success"] = thanks_str
      redirect_to root_url
    else
      render :new
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
