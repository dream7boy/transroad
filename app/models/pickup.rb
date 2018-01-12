class Pickup < ApplicationRecord
  belongs_to :shipment, optional: true

  validates :shipment, presence: true
  validates :prefecture, presence: true
  validates :address, presence: true
end
