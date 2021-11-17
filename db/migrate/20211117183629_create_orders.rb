class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :cart, null: false, foreign_key: true, type: :uuid
      t.integer :amount
      t.boolean :is_fulfilled

      t.timestamps
    end
  end
end
