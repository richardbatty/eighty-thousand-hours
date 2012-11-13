require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def authorize_admin!
    authenticate_user!
    raise CanCan::AccessDenied unless can? :access, :admin
  end

  def after_sign_in_path_for(resource)
    if current_user.etkh_profile.nil?
      # user doesn't have an 80k profile
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    else
      # user has an 80k profile - take them to edit page
      edit_user_etkh_profile_path(current_user, current_user.etkh_profile)
    end
  end
end
