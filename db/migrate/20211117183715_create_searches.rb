class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :content

      t.timestamps
    end
  end
end
