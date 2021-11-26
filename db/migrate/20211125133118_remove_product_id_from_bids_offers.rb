class RemoveProductIdFromBidsOffers < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :bids_offers, :products
  end
end
