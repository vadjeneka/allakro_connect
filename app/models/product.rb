class Product < ApplicationRecord
  belongs_to :store
  has_many :bids
end
