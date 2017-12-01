class Shipment < ApplicationRecord
  belongs_to :shipper
  has_many :deals, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :deliveries, dependent: :destroy

  validates :pickups, presence: true
  validates :deliveries, presence: true
  accepts_nested_attributes_for :pickups, allow_destroy: true
  accepts_nested_attributes_for :deliveries, allow_destroy: true
end
