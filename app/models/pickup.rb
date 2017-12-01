class Pickup < ApplicationRecord
  belongs_to :shipment

  validates :prefecture, presence: true
  validates :address, presence: true
end
