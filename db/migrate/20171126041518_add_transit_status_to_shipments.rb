class AddTransitStatusToShipments < ActiveRecord::Migration[5.1]
  def change
    add_column :shipments, :transit_status, :string
  end
end
