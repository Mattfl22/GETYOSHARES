class DashboardPolicy < ApplicationPolicy
  class Scope < Scope
    # scope que pour l'index !!!
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    true
  end
end
