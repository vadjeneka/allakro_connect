class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats, id: :uuid do |t|
      t.text :name
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :receiver, null: false, class:'User', type: :uuid
      t.timestamps
    end
  end
end
