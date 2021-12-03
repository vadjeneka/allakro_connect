class Account < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :transactions, dependent: :destroy

  def deposit(amount) #TODO: methode pour faire un depot effectué par le user
    update(balance: self.balance + amount) if amount > 0
  end

  def withdraw(amount) #TODO: methode pour faire un retrait effectué par le user
    if amount <= self.balance && amount > 0
      update(balance: self.balance - amount)
      return amount
    end
    return 0
  end

  def purchase(product_price) #TODO: effectuer un achat c'est comme retrait 
    withdraw(product_price)
  end

  def sale(product_price) #TODO: effectuer une vente c'ets comme un depot
    deposit(product_price)
  end

  def hold #TODO: bloquer l'argent
  end

  def release #TODO: debloquer l'argent et renvoie
  end

end
