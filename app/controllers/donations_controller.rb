class DonationsController < ApplicationController
  load_and_authorize_resource :only => [:new,:destroy,:edit,:update]

  def index
    @donations = Donation.all
  end

  def create
    @donation = Donation.new(params[:donation])
    if !@donation.user_id
      @donation.user_id = current_user.id
    end

    if @donation.save
      flash[:"alert-success"] = "Thanks #{current_user.first_name}, your donation is being processed!"
      redirect_to root_url 
    else
      render :new
    end
  end

  def new
    @donation = Donation.new( :user => current_user )
  end
end
