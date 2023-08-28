class CreateMoves < ActiveRecord::Migration[6.1]
  def change
    create_table :moves, id: :uuid do |t|
      t.string :first_last_name_owner
      t.string :sexe
      t.string :function
      t.date :date_of_birth
      t.string :new_destination
      t.string :family_location_place
      t.timestamps
    end
  end
end
