class BidsController < ApplicationController
  def index
    if current_user
      if current_user.first_name == nil && current_user.town == nil && current_user.city == nil
        redirect_to edit_profile_path(current_user)
      end 
    end
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