class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :facilities do |t|
      t.references :shipper, foreign_key: true
      t.string :name
      t.string :prefecture
      t.string :address

      t.timestamps
    end
  end
end
