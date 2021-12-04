class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :type_transaction
      t.integer :amount
      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
