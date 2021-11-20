class CartsController < ApplicationController
  def index
    @carts = current_user.carts.includes(:line_items, :products).where(validated: false)
    # raise @carts.inspect
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to user_carts_path(current_user), notice: 'Your cart was successfully deleted' # TODO: Redirect to cart path
  end
end