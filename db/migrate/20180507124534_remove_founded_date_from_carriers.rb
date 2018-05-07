class RemoveFoundedDateFromCarriers < ActiveRecord::Migration[5.1]
  def change
    remove_column :carriers, :founded_date, :date
  end
end
