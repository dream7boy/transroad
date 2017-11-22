class CreateDeals < ActiveRecord::Migration[5.1]
  def change
    create_table :deals do |t|
      t.references :shipment, foreign_key: true
      t.references :carrier, foreign_key: true
      t.string :deal_status
      t.integer :bid_rate

      t.timestamps
    end
  end
end
