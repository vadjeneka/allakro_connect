class BidsOffer < ApplicationRecord
  belongs_to :bid
  belongs_to :user
  
end
