class BidsController < ApplicationController
  def index
    @bids = Bid.includes(:offers).active
    @coming_bids = Bid.waiting
    @unvalidated = Bid.includes(:offers).closed
    
  end

  def show
    @bid = Bid.find(params[:id])
    @top_offer = @bid.offers.top
    # @unvalidated_bid = @unvalidated.find(params[:id])
    # @winner = @unvalidated_bid.offers.top
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
    else
      # raise @bid.errors.messages_for(:start_date).join(',').inspect
      flash[:error] = "Enchère non enregistrée"
      render 'new'
    end
  end

  def destroy
    @bid.find(params[:id])
    @bid.update(state: "cancelled")
    redirect_to bids_path, notice: "Your bid was cancelled"
  end

  def edit
    @bid.find(params[:id])
    @bid.update(is_validated: true)
    redirect_to bids_path, notice: "Bid validated"
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