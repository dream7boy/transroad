class AddSiteUrlToCarriers < ActiveRecord::Migration[5.1]
  def change
    add_column :carriers, :site_url, :string
    add_column :carriers, :ceo_name, :string
    add_column :carriers, :founded_date, :date
    add_column :carriers, :capital, :string
    add_column :carriers, :employee_numbers, :string
    add_column :carriers, :company_description, :text
  end
end
