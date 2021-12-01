class OrdersController < ApplicationController

  def index
    if params[:user_id]
      if current_user && current_user.orders
        @orders = current_user.orders
      end
    end
    if params[:store_id]
      store = Store.includes(:orders).find(params[:store_id])
      @store_orders = store.orders
    end
  end

  def show
    if params[:user_id]
      @user_order = Order.includes(:user, :cart).find(params[:id])
    end
    if params[:store_id]
      @order = Order.includes(:user, :cart).find(params[:id])
    end
  end

  def create
    cart = Cart.find(params[:cart_id])
    @order = Order.new(user_id: current_user.id, cart_id: cart.id, amount: cart.total_price)

    if @order.save
      # TODO: Set cart to validated: true
      cart.update(validated: true)
      redirect_to user_orders_path(current_user), notice: 'Order was successfully created'
    else
      flash[:error] = "Couldn't create order"
      redirect_to user_carts_path(current_user)
    end
  end

  def update
    order = Order.find(params[:id])
    # raise order.inspect
    order.update(is_fulfilled: true) # TODO: Set is_fulfilled to string with some state
    redirect_to store_orders_path(order.cart.store)
  end

  def validate_order
    @order = Order.find(params[:id])
    @order.update(state: "validated")
    # TODO: Si la commande est confirmé, redirect de l'argent de l'argent depuis le compte de l'acheteur
    # TODO: Payer le vendeur
    # TODO: Diminuer les stocks des produits
    redirect_to store_orders_path(@order.cart.store), notice: "La commande ##{@order.id[0,7].upcase} a été validée"
  end

  def reject_order
    @order = Order.find(params[:id])
    @order.update(state: "cancelled")
    redirect_to store_orders_path(@order.cart.store), notice: "La commande ##{@order.id[0,7].upcase} a été réjeté"
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to user_carts_path(current_user), notice: "Order was successfully destroyed"
  end
end