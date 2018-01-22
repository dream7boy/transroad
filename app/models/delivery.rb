class Delivery < ApplicationRecord
  belongs_to :shipment, optional: true

  validates :shipment, presence: true
  validates :prefecture, presence: true
end
