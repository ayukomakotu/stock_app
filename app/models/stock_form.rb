class StockForm
    include ActiveModel::Model
    # StockFormでメソッドとして使えるようにする
    attr_accessor :day, :process, :process_number, :purpose, :number, :item_id, :user_id, :id

    def save
        Report.create(user_id: user_id, item_id: item_id, process: process, 
                process_number: process_number, day: day, purpose: purpose)
    end




end