class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.integer :quantity

      t.timestamps
    end
  end
end
