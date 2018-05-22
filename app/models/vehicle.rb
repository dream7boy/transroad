class Vehicle < ApplicationRecord
  belongs_to :carrier, optional: true

  validates :load_capacity, presence: true
  validates :vehicle_type, presence: true
  validates :type_specifications, presence: true
  validates :feature, presence: true
  validates :quantity, presence: true
  validates :carrier, presence: true

  TYPES = %w(バン 平ボディ 平ボディ・幌 ウィング・アルミ ウィング・幌 ユニック ダンプ 重機運搬)
  SPECIFICATIONS = %w(標準 ワイド ロング ワイド＆ロング)
  FEATURES = %w(標準 パワーゲート エアサス パワーゲート＆エアサス 冷凍・冷蔵 保冷)

end
