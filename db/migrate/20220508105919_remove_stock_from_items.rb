class RemoveStockFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :stock, :integer
  end
end
