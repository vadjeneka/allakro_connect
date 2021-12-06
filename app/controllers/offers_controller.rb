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
    @offer = @bid.offers.build(params_offer)
    top = @bid.offers.top.first&.amount.nil? ? 0 : @bid.offers.top.first&.amount
    @offer.with_lock do
      if @offer.amount > top
        Transaction.hold(@offer)
        if @offer.save
          redirect_to store_product_bid_path(@bid.product.store, @bid.product, @bid), notice: "Votre offre a été enregistrée"
        else
          flash[:error] = "Your offer was not saved"
          render "new"
        end
      else
        redirect_to store_product_bid_path(@bid.product.store, @bid.product, @bid), notice: "Votre offre est inférieure à l'offre gagnante, faites une nouvelle offre !"
      end
    end
  end


  def historic
    @offers = Offer.all.order(created_at: :desc)
  end

  def details
    @offer = Offer.find(params[:id])
    @offer = @bid.offers.build(params_offer)
    top = @bid.offers.top.first&.amount.nil? ? 0 : @bid.offers.top.first&.amount
    @offer.with_lock do
      if @offer.amount > top
        Transaction.hold(@offer)
        if @offer.save
          redirect_to store_product_bid_offers_path(@bid.product.store, @bid.product, @bid), notice: "Votre offre a été enregistrée"
        else
          flash[:error] = "Your offer was not saved"
          render "new"
        end
      else
        redirect_to store_product_bid_offers_path(@bid.product.store, @bid.product, @bid), notice: "Votre offre est inférieure à l'offre gagnante, faites une nouvelle offre !"
      end
    end
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
