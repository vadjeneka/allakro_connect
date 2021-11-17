class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :balance

      t.timestamps
    end
  end
end
