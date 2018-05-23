class ChangeDatatypeLoadCapacityToFloat < ActiveRecord::Migration[5.1]
  def self.up
    change_column :vehicles, :load_capacity, 'float USING CAST(load_capacity AS float)', null: false, default: 0
  end

  def self.down
    change_column :vehicles, :load_capacity, :string
  end
end
