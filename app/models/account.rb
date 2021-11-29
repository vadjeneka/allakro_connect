class Account < ApplicationRecord
  belongs_to :user, dependent: :destroy
  
  def deposit(amount)
    @balance += amount if amount > 0
    return 0
  end

  def withdraw(amount)
    if amount <= @balance && amount > 0
      @balance -= amount
      return amount
    end
    return 0
  end

end
