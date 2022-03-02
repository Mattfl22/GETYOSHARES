class Project < ApplicationRecord
  belongs_to :user
  has_many :products
  has_many :revenues
  has_many :tokens
  has_one_attached :photo
  has_many :transactions, through: :tokens
  has_many :tracks, through: :products
end
