class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def authorize_admin!
    authenticate_user!
    raise CanCan::AccessDenied unless current_user.has_role? :admin
  end
end
