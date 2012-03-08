class CharitiesController < ApplicationController
  load_and_authorize_resource :only => [:destroy,:edit,:update]

  def index
    @charities = Charity.all
  end

  def show
    @charity = Charity.find(params[:id])
  end

  def new
    @charity = Charity.new( :user => current_user )
    authorize! :create, Charity, :message => "You need to <a href='/accounts/sign_in'>sign in</a> or <a href='/join'>sign up</a> to create a charity!".html_safe
  end

  def create
    @charity = Charity.new(params[:charity])

    if @charity.save
      flash[:"alert-success"] = "Successfully added #{@charity.name}. Go ahead and make your donation!"
      redirect_to new_donation_path 
    else
      render :new
    end
  end
end
