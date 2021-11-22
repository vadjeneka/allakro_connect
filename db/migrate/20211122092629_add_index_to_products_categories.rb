class AddIndexToCategoriesProducts < ActiveRecord::Migration[6.1]
  def change
    add_index :categories_products, [:product_id, :category_id], unique: true
    add_index :categories_products, [:category_id, :product_id], unique: true
  end
end
