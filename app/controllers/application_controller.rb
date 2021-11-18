class ApplicationController < ActionController::Base
  def set_user_store_cart(user, store)
    user_store_cart ||= Cart.find_by(user_id: user.id, store_id: store.id)
    if user_store_cart.present?
      @user_store_cart = user_store_cart
    else
      user_store_cart = nil
    end

    if user_store_cart == nil
      @user_store_cart = Cart.create(user_id: user.id, store_id: store.id)
    end
  end
end
