class BidsController < ApplicationController
  def index
    @bids = Bid.all
    # @bids = Bid.where(product_id: product.id)
    # @bids = product.bids
  end

  def show
    @bid = Bid.find(params[:id])
  end

  def new
    @bid = product.bids.build
  end

  def create
    @bid = product.bids.build(params_bid)
    if @bid.save
      #decrement the stock of this product

      flash[:notice] = "Succes ! #{@bid.product.name} est passé(e) aux enchères"
      redirect_to product_bids_path(@bid.product)
    else
      flash[:error] = "Erreur ! Ce produit n'est pas aux enchères"
      render :new
    end
  end

  def destroy
    @bid = Bid.find(params[:id])
    @bid.destroy
    redirect_to product_bids_path(@bid.product)

    #increment the stock of this product
  end

  
  private
  def product
    @product ||= Product.find(params[:product_id])
  end

  def params_bid
    params.require(:bid).permit(:initial_price, :start_date, :end_date, :product_id)
  end
end
