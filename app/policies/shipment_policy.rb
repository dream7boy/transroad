class ShipmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # Anyone(users) can view any shipments.
      scope.all # => Shipment.all

      # Display only shipments of owner
      # scope.where(shipper: user)
    end
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

  def my_show?
    user_is_owner? && scope.where(:id => record.id).exists?
  end

  def create?
    true # Anyone(signed in) can create a shipment
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_is_owner?
    # Inside a policy:
    # 1. 'user' is the current_user from the Devise
    # 2. 'record' is the argument passed to 'authorize' in Controller.
    record.shipper == user
  end
end
