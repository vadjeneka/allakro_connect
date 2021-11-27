# Auto generate with notifications gem.
class Notification < ActiveRecord::Base
  include Notifications::Model

  # Write your custom methods...
  scope :all_unread, ->(user, chat) { where(user_id:user, chat_id:chat, read_at: false)}
  scope :all_unread_user, ->(user) { where(user_id:user, read_at: false)}
end
