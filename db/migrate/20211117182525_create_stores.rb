class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :city
      t.string :town
      t.references :user, null: false, foreign_key: true, type: :uuid, unique: true

      t.timestamps
    end
  end
end
