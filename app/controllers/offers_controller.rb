class OffersController < ApplicationController
  
  def index
  end

  def show
  end

  def new
    @bid = Bid.find(params[:bid_id])
    @offers = @bids.offers.build
  end

  def create
    @bid = Bid.find(params[:bid_id])
    @offers = Offer.find_by(bid_id: params[:bid_id])
    # First offer
    
    if params_offer[:amount].to_i <= @bid.initial_price
      flash[:error] = "Offre non enregistrée: elle doit être supérieure au prix initial"
      redirect_to store_product_bid_path(@bid.product.store,@bid.product,@bid)
    elsif @offers == nil
      @offer = @bid.offers.build(params_offer)
      @offer.save
      redirect_to store_product_bid_offers_path(@bid.product.store, @bid.product, @bid), notice: "Votre offre a été enregistrée"
    else
    # other offers
      @offer = @bid.offers.build(params_offer)
      if @offer.amount > @bid.offers.top.first.amount
        @offer.save
        redirect_to store_product_bid_offers_path(@bid.product.store, @bid.product, @bid), notice: "Votre offre a été enregistrée"
      else
        flash[:error] = "Offre non enregistrée: inferieure à l'offre gagnante"
        redirect_to store_product_bid_path(@bid.product.store,@bid.product,@bid)
      end
    end

    # if params_offer[:amount].to_i <= @bid.initial_price && @offers == nil
    #   flash[:error] = "Offre non enregistrée: inferieure au prix initial"
    #   redirect_to store_product_bid_path(@bid.product.store,@bid.product,@bid)
    
    # else
    #     @offer = @bid.offers.build(params_offer)
    #     if @offer.amount > @bid.offers.top.first.&.amount
    #       @offer.save
    #       redirect_to store_product_bid_offers_path(@bid.product.store, @bid.product, @bid), notice: "Votre offre a été enregistrée"
    #     else
    #       flash[:error] = "Offre non enregistrée: inferieure à l'offre gagnante"
    #       redirect_to store_product_bid_path(@bid.product.store,@bid.product,@bid)
    #     end
    # end 
  end

  def historic
    @offers = Offer.all.order(created_at: :desc)
  end

  def details
    @offer = Offer.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def params_offer
    params.require(:offer).permit(:user_id, :bid_id, :amount).merge!(user_id: current_user.id)
  end
end
