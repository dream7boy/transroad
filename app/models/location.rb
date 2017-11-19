class Location < ApplicationRecord
  belongs_to :facility
  belongs_to :shipment
end
