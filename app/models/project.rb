class Project < ApplicationRecord
  belongs_to :user
  has_many :products
  has_many :revenues
  has_many :tokens
end
