# frozen_string_literal: true
# This migration comes from notifications (originally 20160328045436)

class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :user, index: true, null: false, foreign_key: true, type: :uuid
      t.references :actor, index: true, class: 'User', type: :uuid
      t.string :notify_type, null: false
      t.string :target_type
      t.references :message,index: true, null: false, foreign_key: true, type: :uuid
      t.references :chat,index: true, null: false, foreign_key: true, type: :uuid
      t.string :second_target_type
      # t.bigint :second_target_id
      t.string :third_target_type
      t.bigint :third_target_id, type: :uuid
      t.boolean :read_at, default: false

      t.timestamps null: false
    end

    add_index :notifications, %i[user_id notify_type]
    # add_index :notifications, [:user_id]
  end
end
