class CreateDeaths < ActiveRecord::Migration[6.1]
  def change
    create_table :deaths, id: :uuid do |t|
      t.string :first_last_name_death
      t.string :sexe
      t.string :function
      t.date :date_of_birth
      t.date :date_of_death
      t.string :death_mode
      t.string :death_mode_description
      t.string :father_name
      t.string :mother_name
      t.string :location
      t.string :state, :default =>  "waiting"

      t.timestamps
    end
  end
end
