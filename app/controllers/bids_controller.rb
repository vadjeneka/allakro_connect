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
    @offer = @bid.offers.build
  end

  def new
    @product = Product.find(params[:product_id])
    @bid = @product.bids.build
  end

  def create
    @product = Product.find(params[:product_id])
    @bid = @product.bids.build(params_bid)
    if @product.stock.quantity > 0
      if @bid.save
        Inventory.create(bid_id: @bid.id, quantity: 1)    
        redirect_to store_product_bids_path(@product.store, @product)
      else
        flash[:error] = "Enchère non enregistrée"
        render 'new'
      end
    else
      flash[:alert] = "Quantité insuffisante !"
        render 'new'
    end
  end

  def destroy
    @bid = Bid.find(params[:id])
    #TODO: decrement inventory of product
    quantity = Inventory.find_by(bid_id: @bid.id)
    quantity&.update(quantity: 0)
    @bid.update(state: "cancelled")
    top = @bid.offers.top.first
    Transaction.release(top)
    
    #TODO: increment stock of product from inventory

    redirect_to bids_path, notice: "Enchère annulée !"
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
    quantity = Inventory.find_by(bid_id: @bid.id)
      if Transaction.bid_purcharse(@bid) 
        @bid.update(validated: true)
        #TODO: increment stock of product from inventory
        @accepted_offer = @bid.offers.top.first
        @accepted_offer.update(accepted: true)
        Stock.decrement_quantity(@bid)
        #TODO: purchase bid product
        quantity.update(quantity: 0)
        redirect_to store_bids_historic_path(@bid.product.store)
        flash[:notice] = "Enchère validée, produit vendu !"
      else
        redirect_to store_bids_historic_path(@bid.product.store)
        flash[:error] = "L'opération a échoué, ressayez svp !"
      end
  
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