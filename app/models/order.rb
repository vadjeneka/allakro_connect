class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart

  scope :in_progress, -> { where(state: 'waiting') }
  scope :cancelled, -> { where(state: 'cancelled') }
  scope :confirmed, -> { where(state: 'validated') }
end
