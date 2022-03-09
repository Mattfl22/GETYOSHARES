class Cart < ApplicationRecord
  STATES = ["pending", "paid"]

  has_many :transactions, dependent: :destroy
  belongs_to :user
end
