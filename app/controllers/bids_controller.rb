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

  def historic
    @bids = Bid.all.order(created_at: :desc)
  end

  def details
    @bid = Bid.find(params[:id])
    @winner = @bid.offers.top
  end

  def update
    @bid = Bid.find(params[:id])
    @bid.update(validated: true)
    redirect_to store_bids_historic_path(@bid.product.store), notice: "Enchère validée, produit vendu !"
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