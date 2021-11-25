class Store < ApplicationRecord
  validates :name, 
            :description,
            :city,
            :town,presence: true
  belongs_to :user
  has_many :carts

  has_many :orders, through: :carts
  has_many :products, :dependent => :destroy
  
  has_one_attached :background
  has_many :chats, :dependent => :destroy
end
