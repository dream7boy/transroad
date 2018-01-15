class AddAreasCoveredToCarriers < ActiveRecord::Migration[5.1]
  def change
    add_column :carriers, :areas_covered, :string
    add_column :carriers, :favorite_products, :string
  end
end
