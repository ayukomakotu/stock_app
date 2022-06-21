class StockForm
    include ActiveModel::Model # 通常のモデルのようにvalidationなどを使えるようにする
    include ActiveModel::Attributes # ActiveRecordのカラムのような属性を加えられるようにする
    # StockFormでメソッドとして使えるようにする
    attr_accessor :process, :process_number, :day, :purpose, :number, :item_id, :user_id, :id

    # validationをひとまとめにする
    with_options presence: true do
        validates :process
        validates :process_number
        validates :day
        validates :purpose, if: :out_stock_purpose
    end

    # 0以上でなければならない
    validates :process_number, numericality: { greater_than: 0 }
    
    def out_stock_purpose
        process == "出庫"
    end

    def save
        Report.create(user_id: user_id, item_id: item_id, process: process, 
                process_number: process_number, day: day, purpose: purpose)
    end




end