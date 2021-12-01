class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers, id: :uuid do |t|
      t.references :bid, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :amount
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
