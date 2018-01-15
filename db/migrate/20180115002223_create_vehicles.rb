class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :size
      t.string :type
      t.integer :quantity
      t.references :carrier, foreign_key: true

      t.timestamps
    end
  end
end
