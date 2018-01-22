class RenameCommodityInPickups < ActiveRecord::Migration[5.1]
  def change
    rename_column :pickups, :commodity, :category
  end
end
