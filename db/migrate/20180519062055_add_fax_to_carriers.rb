class AddFaxToCarriers < ActiveRecord::Migration[5.1]
  def change
    add_column :carriers, :fax, :string
  end
end
