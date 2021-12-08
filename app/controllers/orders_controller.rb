class OrdersController < ApplicationController

  def index
    if params[:user_id]
      if current_user && current_user.orders
        @user_orders = current_user.orders.order("created_at DESC")
      end
    end
    if params[:store_id]
      store = Store.includes(:orders).find(params[:store_id])
      @store_orders = store.orders.order("created_at DESC")
    end
  end

  def show
    if params[:user_id]
      @user_order = Order.includes(:user, :cart).find(params[:id])
    end
    if params[:store_id]
      @store_order = Order.includes(:user, :cart).find(params[:id])
    end
  end

  def create
    cart = Cart.find(params[:cart_id])
    @order = Order.new(user_id: current_user.id, cart_id: cart.id, amount: cart.total_price)

    if @order.save
      cart.update(validated: true)
      OrderMailer.with(order: @order).new_order_email.deliver_later
      redirect_to user_orders_path(current_user), notice: 'Votre commande a bien été enregistré'
    else
      flash[:error] = "Nous n'avons pas pu enregistré votre commande"
      redirect_to user_carts_path(current_user)
    end
  end
  
  def update
    order = Order.find(params[:id])
    redirect_to store_orders_path(order.cart.store)
  end

  def validate_order
    @order = Order.find(params[:id])
    validate_user_order(@order) 
    # TODO: Diminuer les stocks des produits
    redirect_to store_orders_path(@order.cart.store)
  end

  def reject_order
    @order = Order.find(params[:id])
    @order.update(state: "cancelled")
    redirect_to store_orders_path(@order.cart.store), notice: "La commande ##{@order.id[0,7].upcase} a été réjeté"
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to user_carts_path(current_user), notice: "Votre commande a été supprimé"
  end

  private
  def validate_user_order(order)
    user_balance = order.user.account.balance
    if user_balance < order.amount
      order.update(state: "cancelled")
      flash[:notice] = "Le propriétaire de la commande n'a pas suffisament de fonds !"
    else
      Transaction.purchase(order)
      @order.update(state: "validated")
      OrderMailer.with(order: @order).confirm_order_email.deliver_later
      flash[:notice] = "La commande a été validée !"
    end
  end
end