class AddDetailsToCarriers < ActiveRecord::Migration[5.1]
  def change
    add_column :carriers, :company_name, :string
    add_column :carriers, :post_code, :string
    add_column :carriers, :address, :string
    add_column :carriers, :name_kanji, :string
    add_column :carriers, :name_furigana, :string
    add_column :carriers, :phone, :string
  end
end
