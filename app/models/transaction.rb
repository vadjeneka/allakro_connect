class Transaction < ApplicationRecord
  belongs_to :account
  default_scope { order('created_at DESC') }

  def self.purchase(order) #TODO: effectuer un achat c'est débiter un buyer pour créditer un seller
    ActiveRecord::Base.transaction do
      order_amount = order.amount
      seller = order.cart.store.user
      buyer = order.cart.user
      withdraw = buyer.account.withdraw(order_amount) 
      seller.account.deposit(order_amount)

      Transaction.create!(type_transaction: "Vente", amount: order_amount, account_id: seller.account.id)
      Transaction.create!(type_transaction: "Achat", amount: order_amount, account_id: buyer.account.id)
    end
  end
end
