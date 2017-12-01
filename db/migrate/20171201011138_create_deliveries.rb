class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.references :shipment, foreign_key: true
      t.string :company_name
      t.string :prefecture
      t.string :address

      t.timestamps
    end
  end
end
