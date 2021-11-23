class Store < ApplicationRecord
  validates :name, 
            :description,
            :city,
            :background,
            :town,presence: true
  belongs_to :user
  has_many :products, :dependent => :destroy
  has_one_attached :background
  has_many :chats, :dependent => :destroy
end
