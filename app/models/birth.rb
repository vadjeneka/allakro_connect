class Birth < ApplicationRecord
  validates :first_name,
            :last_name,
            :birth_date,
            :sexe,
            :location,
            :birth_date,
            :father_name,
            :mother_name,
            :location,
            :date,
            :valid, presence: true
end
