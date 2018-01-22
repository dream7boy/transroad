class RenameCommodityInShipments < ActiveRecord::Migration[5.1]
  def change
    rename_column :shipments, :commodity, :category
  end
end
