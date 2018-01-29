class DealPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(carrier: user)
    end
  end

  def quotes_make?
    record.carrier == user
  end

  def quotes_update?
    record.carrier == user
  end

  def create?
    true
  end

  def no_value?
    true
  end

  def to_next_transit?
    user_is_owner?
  end

  def pre_transit_index?
    true
  end

  def in_transit_index?
    true
  end

  def post_transit_index?
    true
  end

  private

  def user_is_owner?
    # Inside a policy:
    # 1. 'user' is the current_user from the Devise
    # 2. 'record' is the argument passed to 'authorize' in Controller.
    record.each { |r| r.carrier == user }
  end
end
