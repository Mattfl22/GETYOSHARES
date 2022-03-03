class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :token
  monetize :amount_cents
end
