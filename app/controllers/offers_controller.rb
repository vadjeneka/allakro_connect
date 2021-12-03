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
    # First offer

    ####
    @bid = Bid.find(params[:bid_id])
    raise @bid.initial_price.inspect
    raise params_offer.inspect
    # if top_amount != nil
    #   top_amount = @bid.offers.top.first.amount
    # end
    # raise top_amount.first.amount.inspect  
    if offer == nil
      @offer = @bid.offers.build(params_offer)
      if @offer.save
        redirect_to store_product_bid_offers_path(@bid.product.store, @bid.product, @bid), notice: "Your offer successfully saved"
      else
        flash[:error] = "Your offer was not saved"
        render "new"
      end
    else
      top_amount = @bid.offers.top.first.amount
      raise top_amount.first.amount.inspect
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
