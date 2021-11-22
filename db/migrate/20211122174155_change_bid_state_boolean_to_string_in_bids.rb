class ChangeBidStateBooleanToStringInBids < ActiveRecord::Migration[6.1]
  def change
    change_column :bids, :bid_state, :string, default: "waiting"
  end
end
