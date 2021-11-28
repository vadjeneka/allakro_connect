class OrdersController < ApplicationController

  def index
    if current_user && current_user.orders
      @orders = current_user.orders
    end
    if params[:store_id]
      store = Store.includes(:orders).find(params[:store_id])
      @store_orders = store.orders
      # raise store.orders.inspect
    end
    # raise @store_orders.inspect
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    cart = Cart.find(params[:cart_id])
    @order = Order.new(user_id: current_user.id, cart_id: cart.id, amount: cart.total_price, is_fulfilled: false)

    if @order.save
      # TODO: Set cart to validated: true
      cart.update(validated: true)
      redirect_to user_orders_path(current_user), notice: 'Order was successfully created'
    else
      flash[:error] = "Couldn't create order"
      redirect_to user_carts_path(current_user)
    end
  end

  def destroy
  end
end