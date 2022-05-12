class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :process
      t.integer :process_number
      t.date :day
      t.string :purpose
      t.integer :confirmer_id
      t.boolean :confirmation, default: false, null: false

      t.timestamps
    end
  end
end
