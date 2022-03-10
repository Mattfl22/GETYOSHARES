class Project < ApplicationRecord
  include Abyme::Model
  belongs_to :user
  has_many :products, dependent: :destroy, inverse_of: :project
  has_many :revenues
  has_many :tokens, dependent: :destroy, inverse_of: :project
  has_one_attached :photo
  has_many :transactions, through: :tokens
  has_many :tracks, through: :products
  abymize :products
  abymize :tokens


  def unit_price
    tokens.first.price
  end

  def number_of_transactions(project)
    transactions.where(token_id: Token.where(project_id: project.id)).count
  end

  def total_amount_invested(project)
    unit_price * number_of_transactions(project).to_i
  end

  def total_amount_available(project)
    project.number_of_tokens * unit_price
  end

  def number_of_buyers(project)
    buyers = transactions.where(token_id: Token.where(project_id: project.id)).group(:user_id).count
    if buyers.values.count == 0
      0
    else
      buyers.values.count
    end
  end

  def project_revenue(project)
    if revenues.find_by(project_id: project) != nil
      revenues.find_by(project_id: project).revenue
    else
      0
    end
  end
end
