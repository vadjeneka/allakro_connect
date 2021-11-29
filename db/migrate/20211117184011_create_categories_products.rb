class CreateCategoriesProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :categories_products, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.references :category, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
