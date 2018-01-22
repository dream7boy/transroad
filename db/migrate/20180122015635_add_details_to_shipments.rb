class AddDetailsToShipments < ActiveRecord::Migration[5.1]
  def change
    add_column :shipments, :size_height, :integer
    add_column :shipments, :size_width, :integer
    add_column :shipments, :size_depth, :integer
    add_column :shipments, :quantity, :integer
    add_column :shipments, :temperature, :string
    add_column :shipments, :duration_start, :date
    add_column :shipments, :duration_end, :date
    add_column :shipments, :frequency, :string
    add_column :shipments, :additional_info, :string
  end
end
