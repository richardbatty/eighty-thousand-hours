class EightyThousandHoursApplicationsController < ApplicationController
  # people who aren't logged in should still be able to see the signup form
  load_and_authorize_resource :only => [:create]

  def new
    @eighty_thousand_hours_application = EightyThousandHoursApplication.new
    @menu_root = "Membership"
    @menu_current = "Join now"
  end

  def create
    if current_user.nil?
      raise CanCan::AccessDenied.new("You need to create an account first!", :create, EightyThousandHoursApplication)
    end

    @eighty_thousand_hours_application = EightyThousandHoursApplication.new(params[:eighty_thousand_hours_application])
    
    if @eighty_thousand_hours_application.save
      current_user.eighty_thousand_hours_application = @eighty_thousand_hours_application

      # fire off an email informing 80k team (join@80k..)
      EightyThousandHoursApplicationMailer.tell_team(current_user).deliver!

      # send an email to the user
      EightyThousandHoursApplicationMailer.thank_applicant(current_user).deliver!

      # add name to 'show your support'
      @supporter = Supporter.new(:name => current_user.name, :email => current_user.email)
      @supporter.save

      thanks_str = "Thank you for your interest in 80,000 Hours, " << current_user.first_name << ". \
        We've received your application and you'll hear from us soon!"
      flash[:"alert-success"] = thanks_str

      # redirects should be full url for browser compatibility
      redirect_to root_url
    else
      render :new
    end
  end
end
