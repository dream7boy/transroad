class CreatePickups < ActiveRecord::Migration[5.1]
  def change
    create_table :pickups do |t|
      t.references :shipment, foreign_key: true
      t.string :company_name
      t.string :prefecture
      t.string :address
      t.string :commodity
      t.integer :weight

      t.timestamps
    end
  end
end
