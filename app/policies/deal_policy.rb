class DealPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(carrier: user)
    end
  end

  def quotes_make?
    user_is_owner?
  end

  def quotes_confirm?
    user_is_owner?
  end

  def quotes_update?
    user_is_owner?
  end

  def create?
    true
  end

  def no_value?
    true
  end

  def to_next_transit?
    record.each { |r| r.carrier == user }
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
    record.carrier == user
  end
end
