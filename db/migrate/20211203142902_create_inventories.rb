class CreateInventories < ActiveRecord::Migration[6.1]
  def change
    create_table :inventories, id: :uuid do |t|
      t.references :bid, null: false, foreign_key: true, type: :uuid
      t.integer :quantity

      t.timestamps
    end
  end
end
