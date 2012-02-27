class SupportersController < ApplicationController
  def new
    @title = "Show your support"
    @og_desc = "Even if you aren't ready to become a member of 80,000 Hours, then show your support by signing our petition!"
    @supporters = Supporter.all
    @supporter = Supporter.new
  end
  
  def create
    @supporter = Supporter.new(params[:supporter])
    if @supporter.save
      # redirects should be full url for browser compatibility
      thanks_str = "Thanks for your support " << @supporter.name << "."
      if !@supporter.dont_email_me
        thanks_str << "We'll keep you updated..."
      end
      flash[:"alert-success"] = thanks_str
      redirect_to root_url
    else
      @supporters = Supporter.all
      render :new
    end
  end
end
