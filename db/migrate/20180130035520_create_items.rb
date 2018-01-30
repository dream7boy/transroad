class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.references :deal, foreign_key: true

      t.timestamps
    end
  end
end
