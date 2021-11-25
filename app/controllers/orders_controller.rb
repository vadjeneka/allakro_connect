class OrdersController < ApplicationController

  def index
    @orders = current_user.orders.includes(:cart)
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