class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.datetime :start_date
      t.datetime :end_date
      t.integer :initial_price
      t.string :state, default: "waiting"

      t.timestamps
    end
  end
end
