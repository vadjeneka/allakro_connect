class LineItemsController < ApplicationController 
  before_action :set_user, only: [:create]

  def create
    product = Product.includes(:store).find(params[:product_id])
    cart = current_user == product.store.user ? nil : user_store_cart(current_user, product.store)
    
    if cart && cart.products.include?(product)
      flash[:notice] = "Vous avez déjà ce produit dans votre panier"
    else
      authorize product
      cart.add_product(product)
      redirect_to store_product_path(product.store, product), notice: "Produit ajouté au panier" # TODO: Redirect to Cart
    end
  end

  def add_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save
    redirect_to user_carts_path(current_user) # TODO: Redirect to cart path
  end

  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity -= 1
    if @line_item.quantity < 1
      @line_item.destroy
      @line_item.cart.destroy if @line_item.cart.line_items.count <= 0
    end
    @line_item.save
    redirect_to user_carts_path(current_user) # TODO: Redirect to cart path
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    @line_item.cart.destroy if @line_item.cart.line_items.count <= 0
    redirect_to user_carts_path(current_user) # TODO: Redirect to cart path
  end

  private
  def set_user
    if current_user.nil?
      redirect_to new_user_session_path
    end
  end
end