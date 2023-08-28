class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services, id: :uuid do |t|
      t.string :first_last_name_owner
      t.string :service_name
      t.string :skill
      t.string :phone_number
      t.string :message
      t.string :state, :default =>  "waiting"

      t.timestamps
    end
  end
end
