class Account < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :transactions, dependent: :destroy


  def deposit(amount) #TODO: methode pour faire un depot effectué par le user
    #raise ::Errors::InvalidAmount if amount < 0
    
    update(balance: self.balance + amount)
  end

  def withdraw(amount) #TODO: methode pour faire un retrait effectué par le user
    if amount <= self.balance && amount > 0
      update(balance: self.balance - amount)
      return amount
    end
    raise ::Errors::UnsufficientFunds
  end


  def hold #TODO: bloquer l'argent
  end

  def release #TODO: debloquer l'argent et renvoie
  end

end
