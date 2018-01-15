class Carrier < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :deals, dependent: :destroy
  has_many :vehicles, dependent: :destroy

  accepts_nested_attributes_for :vehicles, allow_destroy: true
end
