class AddDateToPickups < ActiveRecord::Migration[5.1]
  def change
    add_column :pickups, :start_date, :date
    add_column :pickups, :end_date, :date
  end
end
