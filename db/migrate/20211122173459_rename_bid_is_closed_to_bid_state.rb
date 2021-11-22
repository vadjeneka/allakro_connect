class RenameBidIsClosedToBidState < ActiveRecord::Migration[6.1]
  def change
    rename_column :bids, :is_closed, :bid_state
  end
end
