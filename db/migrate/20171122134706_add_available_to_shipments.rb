class AddAvailableToShipments < ActiveRecord::Migration[5.1]
  def change
    add_column :shipments, :available, :boolean
  end
end
