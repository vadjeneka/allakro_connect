class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :store
  has_many :carts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    scope :all_expect, -> (user){ where.not(id: user.id)}
    # Ex:- scope :active, -> {where(:active => true)}

    has_many :chats
end
