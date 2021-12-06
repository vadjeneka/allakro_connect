class OffersController < ApplicationController
  before_action :authenticate_user!

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
    top = @bid.offers.top.first&.amount.nil? ? top = 0 : top = @bid.offers.top.first&.amount
    if @offer.amount > @bid.initial_price &&  @offer.amount > top
      if @offer.user.account.balance >= @offer.amount    
        @offer.with_lock do
          Transaction.release(@offer)
          if @offer.save
            Transaction.hold(@offer)
            redirect_to store_product_bid_path(@bid.product.store, @bid.product, @bid), notice: "Votre offre a été enregistrée"
          else
            flash[:error] = "Votre offre n'a pas été enregistré"
            redirect_to store_product_bid_path(@bid.product.store,@bid.product,@bid)
          end
        end
      else
        flash[:error] = "Solde insuffisant"
        redirect_to store_product_bid_path(@bid.product.store,@bid.product,@bid)
      end
    else
      flash[:alert] = "L'offre est inférieure prix initial ou à la meilleure offre !"
      redirect_to store_product_bid_path(@bid.product.store,@bid.product,@bid)
    end 
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
