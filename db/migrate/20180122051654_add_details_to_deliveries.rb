class AddDetailsToDeliveries < ActiveRecord::Migration[5.1]
  def change
    add_column :deliveries, :post_code, :string
    add_column :deliveries, :street, :string
    add_column :deliveries, :time, :string
  end
end
