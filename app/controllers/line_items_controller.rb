class LineItems < ApplicationController
  before_action :get_user_store_cart, only: [:create]

  def create
    # product = Product.find(params[:product_id]).include(:store)
    user_store_cart = @user_store_cart
    @product = Product.include(:store).first
    @store = Store.include(:products).first

    if user_store_cart.products.include?(@product)
      @line_item = user_store_cart.line_items.find_by(product_id: @product.id)
      @line_item.quantity += 1 
    else
      @line_item = LineItem.new
      @line_item.product_id = @product.id
    end
  end

  private
  def get_user_store_cart
    set_user_store_cart(curent_user, @product.store)
  end
end