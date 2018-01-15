class AddDetailsToShippers < ActiveRecord::Migration[5.1]
  def change
    add_column :shippers, :company_name, :string
    add_column :shippers, :post_code, :string
    add_column :shippers, :prefecture, :string
    add_column :shippers, :ward, :string
    add_column :shippers, :street, :string
    add_column :shippers, :industry, :string
    add_column :shippers, :name_kanji, :string
    add_column :shippers, :name_furigana, :string
    add_column :shippers, :phone, :string
  end
end
