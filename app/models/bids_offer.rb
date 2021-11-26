class BidsOffer < ApplicationRecord
  belongs_to :bid
  belongs_to :user

  scope :the_top_offer, -> {order(amount: :desc)}
end
