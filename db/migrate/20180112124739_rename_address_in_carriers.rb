class RenameAddressInCarriers < ActiveRecord::Migration[5.1]
  def change
    rename_column :carriers, :address, :prefecture
  end
end
