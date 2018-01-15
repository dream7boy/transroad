class Vehicle < ApplicationRecord
  belongs_to :carrier

  SIZES = %w(軽貨物 小型 中型 大型 その他)
  VEHICLE_TYPES =
    %w(平ボディ 平ボディ（幌付き） バン バン（保冷） バン（冷凍・冷蔵）
        ウィング ウィング（保冷） ウィング（冷凍・冷蔵） 幌ウィング)
end
