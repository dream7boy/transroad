class AddIndexToDeals < ActiveRecord::Migration[5.1]
  def change
    add_index :deals, [:carrier_id, :shipment_id], unique: true
  end
end
