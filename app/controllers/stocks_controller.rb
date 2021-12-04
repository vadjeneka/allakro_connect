class StocksController < ApplicationController
  def index
    @stock = product.stock
  end

  def new
    # @user = current_user
    # @store = Store.find(params[:store_id])
    # @product = Product.find(params[:product_id])
    # @stock = Stock.new
  end

  def show
    # id = params[:id]
    # @stock = Stock.find(id)
  end

  def create
    # @product = Product.find(params[:product_id])
    # @stock = Stock.new(stock_params)
    # if @stock.save
    #   redirect_to user_store_products_path(@product), notice: 'stock was successfully created'
    # else
    #   flash[:error] = "stock could not be created"
    #   render 'new'
    # end
  end

  def edit
    # @user = current_user
    # @store = Store.find(params[:store_id])
    # @product = Product.find(params[:product_id])
    # @stock = Stock.find(params[:stock_id])
  end

  def update
    # @stock = Stock.find(params[:id])
    # if @stock.update(stock_params)
    #   redirect_to user_store_product_stocks_path(), notice: 'stock updated successfully'
    # else
    #   flash[:error] = 'Cannot update stock'
    #   render 'edit'
    # end
  end

  def destroy
    # @stock = Stock.find(params[:id])
    # @stock.destroy
    # redirect_to user_store_product_stocks_path(), notice: 'stock deleted successfully'
  end


  private 

  def product
    @product ||= Product.find(params[:product_id])
  end
  
  def stock_params
    params.require(:stock).permit(
      :quantity,
      :product_id,
    )
  end
end
