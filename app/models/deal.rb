class Deal < ApplicationRecord
  belongs_to :shipment
  belongs_to :carrier
  has_many :items, dependent: :destroy

  validates :shipment, presence: true
  validates :carrier_id, uniqueness: { scope: [:shipment_id] }

  validates :items, presence: true
  accepts_nested_attributes_for :items, allow_destroy: true
end
