class Offer < ApplicationRecord
  belongs_to :bid
  belongs_to :user

  scope :top, -> { order(amount: :desc).limit(1) }
  # scope :winner, -> {join(:bids).where(state:"closed")}
  
end
