class CreateTendances < ActiveRecord::Migration[6.1]
  def change
    create_table :tendances, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
