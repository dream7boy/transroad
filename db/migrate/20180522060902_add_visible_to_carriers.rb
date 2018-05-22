class AddVisibleToCarriers < ActiveRecord::Migration[5.1]
  def change
    add_column :carriers, :visible, :boolean
  end
end
