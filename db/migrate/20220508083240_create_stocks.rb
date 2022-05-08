class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.integer :number
      # item_idをuniqueにする
      t.references :item, null: false, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
