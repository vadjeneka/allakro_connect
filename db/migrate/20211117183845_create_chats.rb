class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats, id: :uuid do |t|
      t.text :name
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :store, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
    add_index :chats, [:user_id, :store_id], unique: true
  end
end
