class Shipment < ApplicationRecord
  belongs_to :shipper
  has_many :locations, dependent: :destroy
  accepts_nested_attributes_for :locations
end
