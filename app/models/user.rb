class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects
  has_many :transactions
  has_many :revenues, through: :projects
  has_many :tokens, through: :transactions
  has_one_attached :photo

  def number_of_token_user
    tokens.count
  end

  def total_amount_invested_user
    sum = 0
    transactions.each do |t|
      sum += Token.find(t.token_id).price
    end
    return sum
  end
end
