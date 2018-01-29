class RenameBidRateInDeals < ActiveRecord::Migration[5.1]
  def change
    rename_column :deals, :bid_rate, :total_price
  end
end
