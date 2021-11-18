class RemoveProductAndQuantityFromCartAndAddStoreReferences < ActiveRecord::Migration[6.1]
  def change
    add_reference :carts, :store, type: :uuid, foreign_key: true
    remove_column :carts, :quantity
    remove_reference :carts, :product
  end
end
