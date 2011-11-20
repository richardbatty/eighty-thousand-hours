class MembersController < ApplicationController
  def index
    @members = Member.all_confirmed
  end

  def show
    @slug = params[:name]
    @member = Member.find_by_slug( @slug )
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
