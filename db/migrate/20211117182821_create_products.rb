class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :weight
      t.boolean :is_available, default: true
      t.references :store, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
