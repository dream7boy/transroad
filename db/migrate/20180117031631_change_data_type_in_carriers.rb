class ChangeDataTypeInCarriers < ActiveRecord::Migration[5.1]
  def change
    change_column :carriers, :areas_covered, :string, array: true, default: [], using: "(string_to_array(areas_covered, ','))"
    change_column :carriers, :favorite_products, :string, array: true, default: [], using: "(string_to_array(favorite_products, ','))"
  end
end
