class Carrier < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :deals, dependent: :destroy
  has_many :vehicles, dependent: :destroy

  validates :company_name, presence: true
  validates :post_code, presence: true
  validates :prefecture, presence: true
  validates :ward, presence: true
  validates :street, presence: true
  validates :site_url, presence: true
  validates :ceo_name, presence: true
  validates :founded_date, presence: true
  validates :capital, presence: true
  validates :employee_numbers, presence: true
  validates :areas_covered, presence: true
  validates :favorite_products, presence: true
  validates :strength_1, presence: true
  validates :strength_2, presence: true
  validates :specialties, presence: true
  validates :name_kanji, presence: true
  validates :name_furigana, presence: true
  validates :phone, presence: true
  validates :vehicles, presence: true

  has_attachment :photo

  accepts_nested_attributes_for :vehicles, allow_destroy: true

  FAVORITE_PRODUCTS =
    %w(精密機器 重量物 展示会用品 建築資材 印刷物 家具 楽器 衣料品 農産物 食料品
       美術品 仏壇・仏具 洋紙 遊技機)
end
