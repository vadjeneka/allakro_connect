class BidsController < ApplicationController
  def index
    @bids = Bid.includes(:offers).active
    @coming_bids = Bid.waiting
    
  end

  def show
    @bid = Bid.find(params[:id])
    @top_offer = @bid.offers.top
  end

  def new
    @product = Product.find(params[:product_id])
    @bid = @product.bids.build
  end

  def create
    @product = Product.find(params[:product_id])
    @bid = @product.bids.build(params_bid)
    if @bid.save
      redirect_to store_product_bids_path(@product.store, @product)
    end
  end

  def destroy
    @bid.find(params[:id])
    @bid.update(state: "cancelled")
    redirect_to bids_path, notice: "Your bid was cancelled"
  end

  # def reservation
  #   if @bid.finished
  #     winner_offer = @bid.offer.top
  #     @winnerOrder = Order.new(user_id: winner_offer.user_id, amount: winner_offer.amount, is_fulfilled: false )
  #     @winnerOrder.save
  #     #TODO: substract the bid offer amount from account
  #   end
  # end

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