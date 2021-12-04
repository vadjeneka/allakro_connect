class Transaction < ApplicationRecord
  belongs_to :account
  default_scope { order('created_at DESC') }
end
