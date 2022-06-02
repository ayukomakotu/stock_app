class StockForm
    include ActiveModel::Model
    # StockFormでメソッドとして使えるようにする
    attr_accessor :day, :process, :process_number, :purpose, :number, :item_id, :user_id, :id

    # validationをひとまとめにする
    with_options presence: true do
        validates :process, presence: true
        validates :process_number, presence: true
        validates :day, presence: true
    end
    
    def save
        Report.create(user_id: user_id, item_id: item_id, process: process, 
                process_number: process_number, day: day, purpose: purpose)
    end




end