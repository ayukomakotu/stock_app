class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :stock
      t.string :unit

      t.timestamps
    end
    add_index :items, :name, unique: true
  end
end
