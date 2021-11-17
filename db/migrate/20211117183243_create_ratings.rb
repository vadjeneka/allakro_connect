class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.integer :rates

      t.timestamps
    end
  end
end
