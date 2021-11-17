class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.integer :quantity
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
