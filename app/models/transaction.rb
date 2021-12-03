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
  
  def self.hold(offer) #TODO: bloquer l'argent de l'offre
    offer_amount = offer.amount
    user_offer = offer.user
    account_offer = user_offer.account
    lock_money = account_offer.withdraw(offer_amount)
    Transaction.create!(type_transaction: "Blocage", amount: lock_money, account_id: account_offer.id)
    Transaction.release(offer)
  end

  def self.release(offer) #TODO: remttre l argent bloqué dans le compte concerné
    bid = offer.bid
    top = bid.offers.top
    user = top.first.user
    user.account.deposit(top.first.amount)
    # raise release_money.inspect
    Transaction.create!(type_transaction: "Déblocage", amount: top.first.amount, account_id: user.account.id)
  end
end
