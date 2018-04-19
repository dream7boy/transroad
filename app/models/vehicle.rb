class Vehicle < ApplicationRecord

  belongs_to :carrier, optional: true

  TYPES = %w(バン 平ボディ 平ボディ・幌 ウィング・アルミ ウィング・幌 ユニック ダンプ 重機運搬)
  SPECIFICATIONS = %w(標準 ワイド ロング ワイド＆ロング)
  FEATURES = %w(標準 パワーゲート エアサス パワーゲート＆エアサス 冷蔵・冷凍 保冷)

end