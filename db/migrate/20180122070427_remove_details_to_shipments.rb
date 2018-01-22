class RemoveDetailsToShipments < ActiveRecord::Migration[5.1]
  def change
    remove_column :shipments, :category, :string
    remove_column :shipments, :size_height, :integer
    remove_column :shipments, :size_width, :integer
    remove_column :shipments, :size_depth, :integer
    remove_column :shipments, :weight, :integer
    remove_column :shipments, :quantity, :integer
    remove_column :shipments, :temperature, :string
    remove_column :shipments, :additional_info, :string
  end
end
