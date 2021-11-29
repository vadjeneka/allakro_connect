class Favorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.boolean :still_favorites?, default: true
      
      t.timestamps
    end
    add_index :favorites, [:user_id, :product_id], unique: true
  end
end
