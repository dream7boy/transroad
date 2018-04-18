class AddFeatureToVehicles < ActiveRecord::Migration[5.1]
  def change
    add_column :vehicles, :type_specifications, :string
    add_column :vehicles, :feature, :string
  end
end
