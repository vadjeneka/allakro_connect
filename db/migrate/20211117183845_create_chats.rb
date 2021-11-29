class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats, id: :uuid do |t|
      t.references :sender, null: false, class: "User", type: :uuid
      t.references :receiver, null: false, class: "User", type: :uuid
      t.string :content

      t.timestamps
    end
  end
end
