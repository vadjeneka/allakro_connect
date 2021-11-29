class AddValidatedStatusOnUserStoreCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :validated, :boolean, default: false 
  end
end
