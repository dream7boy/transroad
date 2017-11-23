class FacilityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(shipper: user)
    end
  end

  def create?
    true
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_is_owner?
    record.shipper == user
  end
end
