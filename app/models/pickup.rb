class Pickup < ApplicationRecord
  belongs_to :shipment, optional: true
  # belongs_to :shipment

  validates :shipment, presence: true
  validates :prefecture, presence: true
  validates :address, presence: true
end
