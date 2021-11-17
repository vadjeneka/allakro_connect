class CreateViews < ActiveRecord::Migration[6.1]
  def change
    create_table :views, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
