class RenameAddressInDeliveries < ActiveRecord::Migration[5.1]
  def change
    rename_column :deliveries, :address, :ward
  end
end
