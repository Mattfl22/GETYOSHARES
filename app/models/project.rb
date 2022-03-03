class Project < ApplicationRecord
  belongs_to :user
  has_many :products
  has_many :revenues
  has_many :tokens
  has_one_attached :photo
  has_many :transactions, through: :tokens
  has_many :tracks, through: :products

  def unit_price
    tokens.first.unit_price
  end

  def number_of_transactions(project)
    transactions.where(token_id: Token.where(project_id: project.id)).count
  end

  def total_amount_invested(project)
    unit_price * number_of_transactions(project)
  end

  def total_amount_available(project)
    project.number_of_tokens * unit_price
  end

  def number_of_buyers(project)
    buyers = transactions.where(token_id: Token.where(project_id: project.id)).group(:user_id).count
    if buyers.values.sum == 0
      0
    else
      buyers.values.sum
    end
  end

  def project_revenue(project)
    revenues.find_by(project_id: project).revenue
  end
end
