class UsersController < ApplicationController
  def index
    get_grouped_users
  end

  def get_grouped_users
    @users = User.membership_confirmed.alphabetical
    @grouped_users = @users.group_by{|user| user.name[0].upcase}
  end

  def show
    @user = User.membership_confirmed.find(params[:id])
    @title = @user.name
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

  def new
    @user = User.new
    @user.build_member
    @user.member.build_eighty_thousand_hours_application
    @user.member.build_eighty_thousand_hours_profile
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
    @user.member.build_eighty_thousand_hours_profile
    
    if @user.save
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
    members = Member.confirmed.order("name ASC")
    @confirmed = ""
    members.each{|m| @confirmed << "\"" + m.name + "\" <" + m.email + ">, "};

    members = Member.unconfirmed.order("name ASC")
    @unconfirmed = ""
    members.each{|m| @unconfirmed << "\"" + m.name + "\" <" + m.email + ">, "};

    authorize! :read, Member
  end
end
