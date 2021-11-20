class CartsController < ApplicationController
  def index
    @carts = current_user.carts.includes(:line_items, :products).where(validated: false)
    # raise @carts.inspect
  end

  def destroy
    @cart = Cart.find(params[:cart_id])
    @cart.destroy
    redirect_to root_path, notice: 'Your cart was successfully destroyed'# TODO: Redirect to CartPage
  end
end