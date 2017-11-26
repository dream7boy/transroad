class DealPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(carrier: user)
    end
  end

  def create?
    true
  end

  def pre_transit_index?
    true
  end

  def to_in_transit?
    user_is_owner?
  end

  def in_transit_index?
    true
  end

  def user_is_owner?
    # Inside a policy:
    # 1. 'user' is the current_user from the Devise
    # 2. 'record' is the argument passed to 'authorize' in Controller.
    record.carrier == user
  end
end
