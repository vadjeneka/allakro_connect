class Store < ApplicationRecord
  validates :name, 
            :description,
            :city,
            :town,presence: true
  belongs_to :user
  has_many :products, :dependent => :destroy
  has_one_attached :background
end
