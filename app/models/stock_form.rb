class StockForm
include ActiveModel::model
# StockFormでメソッドとして使えるようにする
attr_accessor :day, :process, :process_number, :purpose, :confirmer_id,
            :confirmation, :number, :item_id, :user_id