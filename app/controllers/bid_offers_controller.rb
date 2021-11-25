class BidOffersController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @bid = Bid.find(params[:bid_id])
    @bids_offer = bid.bids_offers.build
  end
  
  def create
    @product = Product.find(params[:product_id])
    @bid = Bid.find(params[:bid_id])

    # TODO: check if this bid is active
    # TODO: check if inputed amount > initial_price
    # TODO: check previsionnal amount
    # TODO: check if previsionnal amount >= inputed amount

    # @bids_offer = bid.bids_offers.build
    @bids_offer = bid.bids_offers.find_or_create(params_bid_offer)
    if @bids_offer.save
      flash[:notice] = "Offre prise en compte !"
      redirect_to product_bid_bid_offers_path(@product,@bid)
    else
      flash[:error] = "Erreur ressayez !"
      render :new
    end
  end

  def edit
  end

  def update
  end

  private
  def bid
    @bid ||= Bid.find(params[:bid_id])
  end

  def user
    @user = User.find(params[:user_id])
  end

  def params_bid_offer
    require(:bid_offer).permit(:amount,:bid_id)
  end
end
