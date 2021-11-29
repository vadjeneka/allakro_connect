class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  scope :comment_by_product, ->(product) {where(product_id: product.id) }
end
