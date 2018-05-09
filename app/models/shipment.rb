class Shipment < ApplicationRecord
  belongs_to :shipper
  has_many :deals, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :deliveries, dependent: :destroy

  # COMMODITIES = %w(精密機器 洋紙 農産物 畜産物 水産物 食料品 飲料品 木材 木工製品 砂利・砂等 金属製品
  #                  鋼材 建材 電気製品 機械・装置 セメント セメント製品 紙・パルプ製品
  #                  石油製品 化学製品 その他危険物 衣料・雑貨 引越貨物 その他)
  # COMMODITIES = %w(精密機器 重量物 展示会用品 建築資材 印刷物 家具 楽器 衣料品 農産物 食料品
  #                  美術品 仏壇・仏具 洋紙 遊技機 その他)
  COMMODITIES = %w(農産物 水産品 石油 石炭 食料品 飲料等 繊維・衣料品 木材・木製品 紙・紙加工品 出版・印刷物 化学製品・ゴム製品 窯業・土石製品 鉄鋼・金属製品 機械・機械部品 家電品・家電部品 輸送機械・輸送機械部品 日用品・雑貨 砂利・砂・石材 廃棄物 コンテナ 引越貨物 その他)

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
