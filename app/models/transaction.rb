class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :token
  has_many :projects, through: :tokens 
end
