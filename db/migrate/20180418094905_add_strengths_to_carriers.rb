class AddStrengthsToCarriers < ActiveRecord::Migration[5.1]
  def change
    add_column :carriers, :strengths, :string, array: true, default: []
    add_column :carriers, :specialties, :string, array: true, default: []
  end
end
