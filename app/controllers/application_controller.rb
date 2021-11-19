class ApplicationController < ActionController::Base

  def user_store_cart(user, store)
    @user_store_cart ||= find_or_create_cart(user, store)
  end

  private
  def find_or_create_cart(user, store)
    cart = Cart.find_by(user_id: user.id, store_id: store.id, validate: false)
    cart.nil? ? Cart.create(user_id: user.id, store_id: store.id) : cart
  end
end
