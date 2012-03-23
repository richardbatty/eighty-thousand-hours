class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env['omniauth.auth']
    auth= Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])  
    if auth
      flash[:notice] = "Signed in successfully."  
      sign_in_and_redirect(:user, auth.user)  
    elsif current_user
      current_user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      flash[:notice] = "Authentication successful!"
      redirect_to edit_user_registration_path current_user
    else  
      pwd = (0...16).map{ ('a'..'z').to_a[rand(26)] }.join
      user = User.new(:name => omniauth['info']['name'], :email => omniauth['info']['email'], :password => pwd, :password_confirmation =>pwd)  
      user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])  
      user.save!  
      flash[:notice] = "Signed in successfully."  
      sign_in_and_redirect(:user, user)  
    end  
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication"
    redirect_to authentications_url
  end
end
