class Facility < ApplicationRecord
  belongs_to :shipper

  PREFECTURES = %w(東京都 神奈川県 大阪府 北海道)
  ADDRESSES = %w(新宿区 川崎市 大阪市 札幌市)
end
