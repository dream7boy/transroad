class ChangeDatatypeLoadCapacityOfVehicles < ActiveRecord::Migration[5.1]
  def self.up
    change_column :vehicles, :load_capacity, 'integer USING CAST(load_capacity AS integer)', null: false, default: 0
  end

  def self.down
    change_column :vehicles, :load_capacity, :string
  end

end
