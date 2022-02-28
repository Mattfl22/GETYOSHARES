class Product < ApplicationRecord
  belongs_to :project
  has_many :tracks
end
