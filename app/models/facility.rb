class Facility < ApplicationRecord
  belongs_to :shipper
  has_many :locations
end
