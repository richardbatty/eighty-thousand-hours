class RegistrationsController < Devise::RegistrationsController
  def new
    session[:user_return_to] ||= request.referer
    super
  end

  def update
    # if user signed up through omniauth then they
    # don't need to provide a password when updating details
    if current_user.omniauth_signup
      @user = User.find(current_user.id)
      if @user.update_attributes(params[:user])
        @user.skip_confirmation!
        flash[:"alert-success"] = "Updated your account details"
        redirect_to edit_registration_path @user
      else
        super
      end
    else
      super
    end
  end
end
