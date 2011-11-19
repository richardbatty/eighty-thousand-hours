class MembersController < ApplicationController
  def index
    # can't just grab all Users as some may not have members
    @members = Member.all( :include => :user );
  end

  def show
    @user = User.find_by_slug( params[:name] )
    if @user
      @member = @user.member
    else
      @error = "We couldn't find a member called '#{params[:name]}', sorry!" 
    end
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
          thanks_str = "Thanks " << @user[:name] << ", we've received your application and will be in touch shortly. The email address we have for you is " << @user[:email] << ", if this is incorrect then please contact info@highimpactcareers.org as soon as possible!";
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
