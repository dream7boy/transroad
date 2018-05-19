class Shipment < ApplicationRecord
  belongs_to :shipper
  has_many :deals, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :deliveries, dependent: :destroy

  VEHICLE_TYPES = %w(平ボディ 平ボディ（幌付き） バン バン（保冷） バン（冷凍・冷蔵）
                     ウィング ウィング（保冷） ウィング（冷凍・冷蔵） 幌ウィング)

  QUERY_ALL = '分からない'
  QUERY_NORMAL_TEMP = '常温'
  QUERY_NORMAL_TEMP_VEHICLES = %w(標準 パワーゲート エアサス パワーゲート＆エアサス)

  validates :pickups, presence: true
  validates :deliveries, presence: true
  # validates :commodity, inclusion: { in: COMMODITIES }
  # validates :car_type, inclusion: { in: VEHICLE_TYPES }
  accepts_nested_attributes_for :pickups, allow_destroy: true
  accepts_nested_attributes_for :deliveries, allow_destroy: true
end
