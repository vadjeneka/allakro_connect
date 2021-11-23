class RenameBidStateToState < ActiveRecord::Migration[6.1]
  def change
    rename_column :bids, :bid_state, :state
  end
end
