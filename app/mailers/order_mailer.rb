class OrderMailer < ApplicationMailer
  default from: 'noreply@jokou.africa'

  def new_order_email
    @order = params[:order]
    mail(to: @order.cart.user.email, subject: "Vous avez reçu une commande!")
  end

  def confirm_order_email
    @order = params[:order]
    mail(to: @order.cart.user.email, subject: "Votre commande a bien été confirmée!")
  end
end

