class RenameRateColumnInShipments < ActiveRecord::Migration[5.1]
  def change
    rename_column :shipments, :rate, :offer_rate
  end
end
