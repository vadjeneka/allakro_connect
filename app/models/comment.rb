class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  scope :comment_by_product, ->(product) {where(product_id: product.id) }
  default_scope { order("created_at DESC") }

  # after_commit :create_notifications, on: :create
  # after_create_commit { broadcast_append_to self.comment.id, locals:{user: self.user} }

  # private
  # def create_notifications
  #   Notification.create do |notification|
  #     notification.notify_type ='post'
  #     notification.actor_id = self.user.id
  #     notification.comment_id = self.id
  #     notification.product_id = self.product.id
  #       notification.user_id = self.product.store.user.id
  #   end
  # end
end
