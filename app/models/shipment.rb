class Shipment < ApplicationRecord
  belongs_to :shipper
  has_many :deals, dependent: :destroy
  # has_many :locations, dependent: :destroy
  # accepts_nested_attributes_for :locations, allow_destroy: true
end
