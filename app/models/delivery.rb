class Delivery < ApplicationRecord
  belongs_to :shipment

  validates :shipment, presence: true
  validates :prefecture, presence: true
  validates :address, presence: true
end
