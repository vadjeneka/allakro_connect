class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :store
  has_many :messages, :dependent => :destroy
end
