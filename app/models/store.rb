class Store < ApplicationRecord
  validates :name, 
            :description,
            :city,
            :town,presence: true
  belongs_to :user
  has_many :carts, :dependent => :destroy

  has_many :orders, through: :carts ,:dependent => :destroy
  has_many :products, :dependent => :destroy

  has_many :comments, through: :products, :dependent => :destroy
  
  has_one_attached :background, :dependent => :destroy
  has_many :chats, :dependent => :destroy
end
