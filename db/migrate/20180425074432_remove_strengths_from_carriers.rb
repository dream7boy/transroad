class RemoveStrengthsFromCarriers < ActiveRecord::Migration[5.1]
  def change
    remove_column :carriers, :strengths, :string, array: true, default: []
  end
end
