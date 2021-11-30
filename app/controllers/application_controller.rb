class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def user_store_cart(user, store)
    @user_store_cart ||= find_or_create_cart(user, store)
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :phone, :town , :city, :password, :password_confirmation)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :phone, :town , :city, :password, :password_confirmation)}
    end
    
  private
  def find_or_create_cart(user, store)
    cart = Cart.find_by(user_id: user.id, store_id: store.id, validated: false)
    cart.nil? ? Cart.create(user_id: user.id, store_id: store.id) : cart
  end
  protect_from_forgery with: :exception

  def authenticate_user
    unless current_user
      redirect_to new_user_session_path, alert: "You don't have access to this page"
    end
  end
end
