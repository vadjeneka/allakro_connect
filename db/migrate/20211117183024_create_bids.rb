class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids, id: :uuid do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.integer :initial_price
      t.boolean :is_closed

      t.timestamps
    end
  end
end
