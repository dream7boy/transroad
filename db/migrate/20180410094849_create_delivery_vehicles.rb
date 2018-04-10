class CreateDeliveryVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :delivery_vehicles do |t|
      t.string :size
      t.string :vehicle_type
      t.integer :quantity
      t.references :deal, foreign_key: true

      t.timestamps
    end
  end
end
