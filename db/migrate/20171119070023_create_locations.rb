class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.references :facility, foreign_key: true
      t.references :shipment, foreign_key: true
      t.string :commodity
      t.integer :weight
      t.string :is_for

      t.timestamps
    end
  end
end
