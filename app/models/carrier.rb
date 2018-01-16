class Carrier < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :deals, dependent: :destroy
  has_many :vehicles, dependent: :destroy

  accepts_nested_attributes_for :vehicles, allow_destroy: true, reject_if: :all_blank

  FAVORITE_PRODUCTS =
    %w(精密機器 重量物 展示会用品 建築資材 印刷物 家具 楽器 衣料品 農産物 食料品
       美術品 仏壇・仏具 洋紙 遊技機)
end
