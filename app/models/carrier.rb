class Carrier < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :deals, dependent: :destroy
  has_many :vehicles, dependent: :destroy

  validates :visible, presence: true
  validates :company_name, presence: true
  validates :post_code, presence: true
  validates :prefecture, presence: true
  validates :ward, presence: true
  validates :street, presence: true
  validates :ceo_name, presence: true
  validates :founded_date_year, presence: true
  validates :founded_date_month, presence: true
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

  # FAVORITE_PRODUCTS = %w(鋼材 洋紙 石油製品 仏壇・仏具 セメント セメント製品)

  FAVORITE_PRODUCTS =
    %w(建築材料 食料品 飲料品 繊維・衣料品 木材・木製品 紙・紙加工品 出版・印刷物 農産物 畜産物 水産品 石油 石炭
       化学製品・ゴム製品 その他危険物 窯業・土石製品 鉄鋼・金属製品 重量物 精密機器 機械・機械部品 家電品・家電部品
       輸送機械・輸送機械部品 砂利・砂・石材 廃棄物 コンテナ 日用品・雑貨 引越貨物 家具 楽器 展示会用品 医薬品 美術品 遊技機 その他)

  def leave
    #leave_atに退会時刻を追記
    update_attribute(:leave_at, Time.current)

    # また、userのメールアドレスの頭にleave_atを追加する。
    # メールアドレスを変更すると原則確認メールが送信されるため、
    # 送信をスキップすることを宣言した上でupdateする。
    new_email = self.leave_at.to_i.to_s + '_' + self.email.to_s

    # devise :confirmable した モデルには skip_confirmation! skip_reconfirmation!
    # というメソッドが追加されるので下記のコードを追加
    # self.skip_reconfirmation!

    update_attributes(email: new_email, visible: false)

    # また、social_profilesが存在する場合はuidの頭にもleave_atを追加する
    # fb,twitter両方連携されている場合があるため、each doしている。
    # social_profiles = self.social_profiles
    # social_profiles.each do |sp|
    #   new_uid = self.leave_at.to_i.to_s + '_' + sp.uid.to_s
    #   sp.update_attribute(:uid, new_uid)
    # end
  end
end
