class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates_presence_of :product
  validates_inclusion_of :values_at, :in => 1..5 
end
