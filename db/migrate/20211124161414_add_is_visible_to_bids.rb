class AddIsVisibleToBids < ActiveRecord::Migration[6.1]
  def change
  add_column :bids, :visible, :boolean, default: true
  end
end
