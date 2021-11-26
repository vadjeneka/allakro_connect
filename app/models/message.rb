class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  # after_commit :create_notifications, on: :create

  private
  # def create_notifications
  #   Notification.create do |notification|
  #     notification.notify_type ='post'
  #     notification.actor = self.user
  #     notification.user = self.chat.user
  #     notification.target = self
  #     notification.second_target = self.chat
  #   end
  # end
end
