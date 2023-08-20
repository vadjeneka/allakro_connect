class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations, id: :uuid do |t|
      t.string :first_last_name_owner
      t.string :sexe
      t.string :function
      t.date :date_of_birth
      t.string :origin_location
      t.string :location_mode
      t.string :family_location_place
      t.string :family_name

      t.timestamps
    end
  end
end
