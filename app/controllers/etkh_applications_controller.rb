class EtkhApplicationsController < ApplicationController
  # people who aren't logged in should still be able to see the signup form
  load_and_authorize_resource :only => [:create]

  def new
    @etkh_application = EtkhApplication.new
    @menu_root = "Membership"
    @menu_current = "Join now"
  end

  def create
    if current_user.nil?
      raise CanCan::AccessDenied.new("You need to create an account first!", :create, EtkhApplication)
    end

    @etkh_application = EtkhApplication.new(params[:etkh_application])
    
    if @etkh_application.save
      current_user.etkh_application = @etkh_application

      # fire off an email informing 80k team (join@80k..)
      EtkhApplicationMailer.tell_team(current_user).deliver!

      # send an email to the user
      EtkhApplicationMailer.thank_applicant(current_user).deliver!

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
