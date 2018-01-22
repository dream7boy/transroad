class RenameAddressInPickups < ActiveRecord::Migration[5.1]
  def change
    rename_column :pickups, :address, :ward
  end
end
