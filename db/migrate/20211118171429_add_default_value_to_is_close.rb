class AddDefaultValueToIsClose < ActiveRecord::Migration[6.1]
  def change
    change_column :bids, :is_closed, :boolean, :default => false
  end
end
