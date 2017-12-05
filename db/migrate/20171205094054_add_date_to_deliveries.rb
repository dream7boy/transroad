class AddDateToDeliveries < ActiveRecord::Migration[5.1]
  def change
    add_column :deliveries, :start_date, :date
    add_column :deliveries, :end_date, :date
  end
end
