class AddWardsToCarriers < ActiveRecord::Migration[5.1]
  def change
    add_column :carriers, :ward, :string
    add_column :carriers, :street, :string
  end
end
