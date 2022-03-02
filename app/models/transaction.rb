class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :token
  after_create :set_token_as_bought

  def set_token_as_bought
    return if token.bought?

    token.update(bought: true)
  end
end
