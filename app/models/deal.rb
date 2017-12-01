class Deal < ApplicationRecord
  belongs_to :shipment
  belongs_to :carrier

  validates :shipment, presence: true
end
