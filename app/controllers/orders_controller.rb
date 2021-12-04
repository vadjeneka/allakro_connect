class OrdersController < ApplicationController

  def index
    if current_user && current_user.orders
      @orders = current_user.orders
    end
    if params[:store_id]
      store = Store.includes(:orders).find(params[:store_id])
      @store_orders = store.orders
    end
  end

  def show
    @user_order = Order.includes(:user, :cart).find(params[:id]) # TODO: and default accepted: false
    if params[:store_id]
      @order = Order.includes(:user, :cart).find(params[:id])
    end
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

  def update
    order = Order.find(params[:id])
    # raise order.inspect
    order.update(is_fulfilled: true) # TODO: Set is_fulfilled to string with some state
    redirect_to store_orders_path(order.cart.store)
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to user_carts_path(current_user), notice: "Order was successfully destroyed"
  end
end