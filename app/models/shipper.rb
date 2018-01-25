class Shipper < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :shipments, dependent: :destroy
  has_many :facilities, dependent: :destroy

  INDUSTRIES = %w(製造 土木・建設 農業 林業 漁業 飲食 小売 卸売 印刷 商社)
end
