class AddBidIdToBidsOffers < ActiveRecord::Migration[6.1]
  def change
    add_reference :bids_offers, :bid, null: false, foreign_key: true, type: :uuid
  end
end
