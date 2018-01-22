class AddDetailsToPickups < ActiveRecord::Migration[5.1]
  def change
    add_column :pickups, :post_code, :string
    add_column :pickups, :street, :string
    add_column :pickups, :time, :string
  end
end
