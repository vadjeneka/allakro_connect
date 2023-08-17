class Birth < ApplicationRecord
  validates :first_name,
            :last_name,
            :date,
            :sexe,
            :location,
            :birth_mode,
            :father_name,
            :mother_name,
            :location,
            :date, 
            :state, presence: true
end
