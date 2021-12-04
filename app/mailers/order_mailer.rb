class OrderMailer < ApplicationMailer
  default from: 'noreply@jokou.africa'

  def new_order_email
    @order = params[:order]
    mail(to: @order.cart.user.email, subject: "You got a new order!")
  end

  def confirm_order_email
    @order = params[:order]
    mail(to: @order.cart.user.email, subject: "Your order has been confirmed!")
  end
end

