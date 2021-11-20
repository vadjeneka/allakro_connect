class LineItemsController < ApplicationController

  def create
    # raise params.inspect
    product = Product.includes(:store).find(params[:product_id])
    cart = user_store_cart(current_user, product.store)

    if cart.products.include?(product)
      flash[:notice] = "You already have this product in your cart"
    else
      @line_item = LineItem.create(product_id: product.id, cart_id: cart.id)
      cart.add_product(product)
    end
    redirect_to root_path, notice: "Product successfully added to cart" # TODO: Redirect to Cart
  end

  def add_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save
    redirect_to user_carts_path(current_user) # TODO: Redirect to cart path
  end

  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.quantity -= 1
    end
    @line_item.save
    redirect_to user_carts_path(current_user) # TODO: Redirect to cart path
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to user_carts_path(current_user) # TODO: Redirect to cart path
  end
end