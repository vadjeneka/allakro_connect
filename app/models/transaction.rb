class Transaction < ApplicationRecord
  belongs_to :account
  default_scope { order('created_at DESC') }

  scope :deposit_and_withdraw, -> { where(type_transaction: "Dépôt").or(where(type_transaction: "Rétrait")) }
  scope :amount_lock, -> { where(type_transaction: ["Blocage", "Déblocage"]).sum(:amount)  }

  # scope :except_auctions, -> { where.not(['type_transaction = ? or type_transaction = ?', 'Blocage', 'Déblocage']) }

  def self.purchase(order) #TODO: effectuer un achat c'est débiter un buyer pour créditer un seller
    ActiveRecord::Base.transaction do
      order_amount = order.amount
      seller = order.cart.store.user
      buyer = order.cart.user
      withdraw = buyer.account.withdraw(order_amount) 
      seller.account.deposit(order_amount)

      Transaction.create!(type_transaction: "Vente", amount: order_amount, account_id: seller.account.id)
      Transaction.create!(type_transaction: "Achat", amount: -order_amount, account_id: buyer.account.id)
    end
  end
  
  def self.hold(offer) #TODO: bloquer l'argent de l'offre
    offer_amount = offer.amount
    user_offer = offer.user
    account_offer = user_offer.account
    lock_money = account_offer.withdraw(offer_amount)
    Transaction.create!(type_transaction: "Blocage", amount: -lock_money, account_id: account_offer.id)
    # Transaction.release(offer)
  end

  def self.release(offer) #TODO: remttre l argent bloqué dans le compte concerné
    bid = offer.bid
    top = bid.offers.top
    user = top.first&.user
    if user
      user.account.deposit(top.first.amount)
      Transaction.create!(type_transaction: "Déblocage", amount: top.first.amount, account_id: user.account.id)
    end
  end

  def self.bid_purcharse(bid)
    ActiveRecord::Base.transaction do
      bid_owner = bid.product.store.user #TODO: on récupère le bid owner
      bid_winner = bid.offers.top.first #TODO: on récuprère le top offer
      offer_winner = bid_winner.amount #TODO: on récupère l'offre gagnante
      Transaction.release(bid_winner)
      bid_winner.user.account.withdraw(offer_winner)
      bid_owner.account.deposit(offer_winner)

      Transaction.create!(type_transaction: "Vente aux enchères", amount: offer_winner, account_id: bid_owner.account.id)
      Transaction.create!(type_transaction: "Achat aux enchères", amount: -offer_winner, account_id: bid_winner.user.account.id)
    end
  end
end
