class CreateShipments < ActiveRecord::Migration[5.1]
  def change
    create_table :shipments do |t|
      t.integer :distance
      t.integer :rate
      t.string :commodity
      t.integer :weight
      t.string :car_type
      t.references :shipper, foreign_key: true

      t.timestamps
    end
  end
end
