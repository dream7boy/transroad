class Shipment < ApplicationRecord
  belongs_to :shipper
  has_many :deals, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :deliveries, dependent: :destroy

  COMMODITIES = %w(農産物 畜産物 水産物 食料品 飲料品 木材 木工製品 砂利・砂等 金属製品
                   鋼材 建材 電気製品 機械・装置 セメント セメント製品 紙・パルプ製品
                   石油製品 化学製品 その他危険物 衣料・雑貨 引越貨物 その他)

  CAR_TYPES = %w(平型 バン型 ウィング型 保冷車 冷凍車 車載車 重機運搬車 危険物運搬車
                 ダンプ 幌 ユニック 海上コンテナ その他)

  PREFECTURES = %w(東京都 神奈川県 大阪府 北海道)
  ADDRESSES = %w(新宿区 川崎市 大阪市 札幌市)

  validates :pickups, presence: true
  validates :deliveries, presence: true
  # validates :commodity, inclusion: { in: COMMODITIES }
  # validates :car_type, inclusion: { in: CAR_TYPES }
  accepts_nested_attributes_for :pickups, allow_destroy: true
  accepts_nested_attributes_for :deliveries, allow_destroy: true
end
