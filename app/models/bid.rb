class Bid < ApplicationRecord
  belongs_to :product
  has_many :offers
  
  has_one :active_bid, -> { where(state: 'active') } 
end
