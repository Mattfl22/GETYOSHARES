class TransactionPolicy < ApplicationPolicy
  class Scope < Scope

  end

  def create?
    true
  end

  def show?
    true
  end
end
