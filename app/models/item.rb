class Item < ApplicationRecord
  belongs_to :deal, optional: true

  validates :deal, presence: true
end
