class DeleteProductIdFromBidsOffers < ActiveRecord::Migration[6.1]
  def change
    remove_column :bids_offers, :product_id
  end
end
