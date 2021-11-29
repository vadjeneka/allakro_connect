class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.integer :quantity, default: 1
      t.references :cart, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
