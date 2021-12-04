class ChangeActiveStorageRecordReferencesToUuid < ActiveRecord::Migration[6.1]
  def change
    def change
      remove_column :active_storage_attachments, :record_id
      add_column :active_storage_attachments, :record_id, :uuid, null: false
    end
  end
end
