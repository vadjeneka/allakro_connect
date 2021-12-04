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
    #TODO: If stock is available however he cannot create a bid
    # raise @product.stock.quantity.inspect
    
    if @bid.save
      #TODO: decrement stock of product
      #TODO: increment inventory of product
      # raise @bid.id.inspect
      Inventory.create(bid_id: @bid.id, quantity: 1)
      # @bid.inventory.bid = @bid.id
      # @bid.inventory.quantity = 1
      
      redirect_to store_product_bids_path(@product.store, @product)
    else
      # raise @bid.errors.messages_for(:start_date).join(',').inspect
      flash[:error] = "Enchère non enregistrée"
      render 'new'
    end
  end

  def destroy
    @bid = Bid.find(params[:id])
    #TODO: decrement inventory of product
    quantity = Inventory.find_by(bid_id: @bid.id)
    quantity.update(quantity: 0)
    @bid.update(state: "cancelled")
    
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
    
    if quantity
      winner = Offer
      @bid.update(validated: true)
      #TODO: increment stock of product from inventory
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