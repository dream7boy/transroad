class Shipment < ApplicationRecord
  belongs_to :shipper
  has_many :deals, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :deliveries, dependent: :destroy

  COMMODITIES = %w(精密機器 洋紙 農産物 畜産物 水産物 食料品 飲料品 木材 木工製品 砂利・砂等 金属製品
                   鋼材 建材 電気製品 機械・装置 セメント セメント製品 紙・パルプ製品
                   石油製品 化学製品 その他危険物 衣料・雑貨 引越貨物 その他)

  VEHICLE_TYPES = %w(平ボディ 平ボディ（幌付き） バン バン（保冷） バン（冷凍・冷蔵）
                     ウィング ウィング（保冷） ウィング（冷凍・冷蔵） 幌ウィング)

  COMPANIES = %w(東京運輸（株） 神奈川運輸（株） 大阪運輸（株） 北海道運輸（株）)
  PREFECTURES = %w(東京都 神奈川県 大阪府 北海道)
  ADDRESSES = %w(新宿区 川崎市 大阪市 札幌市)

  validates :pickups, presence: true
  validates :deliveries, presence: true
  # validates :commodity, inclusion: { in: COMMODITIES }
  # validates :car_type, inclusion: { in: VEHICLE_TYPES }
  accepts_nested_attributes_for :pickups, allow_destroy: true
  accepts_nested_attributes_for :deliveries, allow_destroy: true
end
