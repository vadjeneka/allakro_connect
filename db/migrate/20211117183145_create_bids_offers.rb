class CreateBidsOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :bids_offers, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :amount
      t.boolean :is_accepted

      t.timestamps
    end
  end
end
