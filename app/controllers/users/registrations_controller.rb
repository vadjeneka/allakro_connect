class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_signup_params, only: [:create]
  # protected

  # def update_resource(resource, user_params)
  #   #raise resource.inspect
  #   #raise user_params.inspect
  #   #raise params[:user].inspect
  #   #raise resource.first_name.inspect 
  #   resource.first_name = params[:user][:first_name]
  #   resource.last_name = params[:user][:last_name]
  #   resource.email = params[:user][:email]
  #   resource.city = params[:user][:city]
  #   resource.phone = params[:user][:phone]
  #   resource.town = params[:user][:town]
  #   resource.save
  # end
  # def user_params
  #   params.require(:user).permit(:first_name, :last_name, :email, :phone, :city, :town)
  # end

  def configure_signup_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :city, :phone, :town, :password, :password_confirmation])
  end
end
