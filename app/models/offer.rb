class Offer < ApplicationRecord
  belongs_to :bid
  belongs_to :user

  scope :top, -> { order(amount: :desc).limit(1) }
end
