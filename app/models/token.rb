class Token < ApplicationRecord
  belongs_to :project
  has_many :transactions
  monetize :price_cents
  scope :bought, -> { joins(:transactions).where(transactions: { active: true }) }
end

# Token.bought
# Token.joins(:transactions).where(transactions: { active: true })
