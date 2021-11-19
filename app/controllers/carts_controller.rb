class CartsController < ApplicationController
  def show
    @carts = Cart.includes(:line_items, :products).find_by(user_id: current_user.id, validated: false)
  end

  def destroy
    @cart = Cart.find(params[:cart_id])
    @cart.destroy
    redirect_to root_path, notice: 'Your cart was successfully destroyed'# TODO: Redirect to CartPage
  end
end