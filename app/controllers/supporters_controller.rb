class SupportersController < ApplicationController
  def new
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
      redirect_to root_url, notice: thanks_str
    else
      render :new
    end
  end
end
