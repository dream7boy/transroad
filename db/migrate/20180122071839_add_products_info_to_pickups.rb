class AddProductsInfoToPickups < ActiveRecord::Migration[5.1]
  def change
    add_column :pickups, :size_height, :integer
    add_column :pickups, :size_width, :integer
    add_column :pickups, :size_depth, :integer
    add_column :pickups, :quantity, :integer
    add_column :pickups, :temperature, :string
    add_column :pickups, :additional_info, :string
  end
end
