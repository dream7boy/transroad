class AddLeaveAtToCarriers < ActiveRecord::Migration[5.1]
  def change
    add_column :carriers, :leave_at, :datetime
  end
end
