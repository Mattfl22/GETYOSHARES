class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def create?
      return true
    end
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
