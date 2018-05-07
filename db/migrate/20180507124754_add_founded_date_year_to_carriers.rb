class AddFoundedDateYearToCarriers < ActiveRecord::Migration[5.1]
  def change
    add_column :carriers, :founded_date_year, :integer
    add_column :carriers, :founded_date_month, :integer
  end
end
