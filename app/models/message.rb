class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  after_commit :create_notifications, on: :create
  after_create_commit { broadcast_append_to self.chat.id, locals:{user: self.user} }

  private
  def create_notifications
    Notification.create do |notification|
      notification.notify_type ='post'
      notification.actor_id = self.user.id
      notification.message_id = self.id
      notification.chat_id = self.chat.id
      if self.chat.user.id == self.user.id
        notification.user_id = self.chat.store.user.id
      else
        notification.user_id = self.chat.user.id
      end
    
    end
  end
end
