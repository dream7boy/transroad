class AddStrengthToCarriers < ActiveRecord::Migration[5.1]
  def change
    add_column :carriers, :strength_1, :string
    add_column :carriers, :strength_2, :string
  end
end
