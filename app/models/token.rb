class Token < ApplicationRecord
  belongs_to :project
  has_many :transactions
end
