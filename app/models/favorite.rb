class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :product

  scope :find_user_favorite, ->(user,product){ where(user_id:user.id, product_id:product.id, still_favorites?: true)}
end