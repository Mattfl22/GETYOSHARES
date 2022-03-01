class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end

  def create?
    return true
  end
  # NOTE: Be explicit about which records you allow access to!
  # def resolve
  #   scope.all
  # end
  def index
    return true  
  end

  def show?
    true
  end

  def update?
    record.user == user
    # - record: the project passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

end
