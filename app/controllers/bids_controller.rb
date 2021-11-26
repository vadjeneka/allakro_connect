class BidsController < ApplicationController
  def index
    @bids = Bid.all
  end

  def show
    @bid = Bid.find(params[:id])
    @bid_offers = @bid.offers
    raise @bid_offers.inspect
  end

  def new
    @product = Product.find(params[:product_id])
    @bid = @product.bids.build
  end

  def create
    @product = Product.find(params[:product_id])
    @bid = @product.bids.build(params_bid)
    if @bid.save
      redirect_to user_store_product_bids_path(current_user, @product.store, @product)
    end
  end

  def destroy
  end

  private
  def params_bid
    params.require(:bid).permit(
      :product_id,
      :start_date,
      :end_date,
      :initial_price
    )
  end
end