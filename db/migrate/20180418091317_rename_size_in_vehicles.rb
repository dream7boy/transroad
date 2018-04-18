class RenameSizeInVehicles < ActiveRecord::Migration[5.1]
  def change
    rename_column :vehicles, :size, :load_capacity
  end
end
