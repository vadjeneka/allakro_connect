class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def user_store_cart(user, store)
    @user_store_cart ||= find_or_create_cart(user, store)
  end

  # def after_sign_in_path_for(resource)
  #   redirect_to root_path
  # end
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end
  
  def after_sign_up_path_for(resource)
    redirect_to root_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :phone, :town , :city, :password, :password_confirmation, :avatar)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :phone, :town , :city, :password, :password_confirmation, :avatar)}
  end
  
  def find_or_create_cart(user, store)
    cart = Cart.find_by(user_id: user.id, store_id: store.id, validated: false)
    cart.nil? ? Cart.create(user_id: user.id, store_id: store.id) : cart
  end
end
