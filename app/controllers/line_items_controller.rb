class LineItems < ApplicationController

  def create
    # product = Product.includes(:store).find(params[:product_id])
    @product = Product.includes(:store).first
    cart = user_store_cart(current_user, @product.store)

    if cart.products.include?(@product)
      flash[:notice] = "You already have this product in your cart"
    else
      @line_item = LineItem.create(product_id: @product.id, cart_id: cart.id)
    end
    redirect_to root_path # TODO: Redirect to Cart
  end

  def destroy
    @user_store_cart.destroy
    flash[:notice] = "You cart has been deleted"
  end
end