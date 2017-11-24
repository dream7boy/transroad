class DealPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(carrier: user)
    end
  end

  def create?
    true
  end
end