class Deal < ApplicationRecord
  belongs_to :shipment
  belongs_to :carrier
  has_many :items, dependent: :destroy
  has_many :delivery_vehicles, dependent: :destroy

  validates :shipment, presence: true
  validates :carrier_id, uniqueness: { scope: [:shipment_id] }

  validates :items, presence: true
  validates :delivery_vehicles, presence: true
  accepts_nested_attributes_for :items, allow_destroy: true
  accepts_nested_attributes_for :delivery_vehicles, allow_destroy: true
end
