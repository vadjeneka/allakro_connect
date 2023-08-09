class CreateBirths < ActiveRecord::Migration[6.1]
  def change
    create_table :births, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :sexe
      t.date :date
      t.string :birth_mode
      t.string :father_name
      t.string :mother_name
      t.string :location
      t.boolean :valid
      
      
      t.timestamps
    end
  end
end
