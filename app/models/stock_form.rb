class StockForm
    include ActiveModel::Model
    # EventFormでメソッドとして使えるようにする
    attr_accessor :user_id, :item_id, :process, :process_number, :day, :purpose, :number
        
    # validationをひとまとめにする
    with_options presence: true do
        
    end

    def save
        @stock.update(number: new_stock)
        Report.create(user_id: current_user.id, item_id: @item.id, process: params[:commit],
            process_number: params[:stock][:process_number], day: day)
    end

    private
    def stock_params
      params.require(:stock).permit(:process_number)
    end

    def report_params
        params.require(:report).permit(:user_id, :item_id, :process, :process_number,
                        :day, :purpose, :confirmer_id, :confirmation)
    end
    # 入出庫の計算　出庫ならstockからprocess_numberをひいた値を返す、入庫なら足した値を返す
    def new_stock
      if params[:commit] == "出庫"
        @stock.number - stock_params[:process_number].to_i
      elsif params[:commit] == "入庫"
        @stock.number + stock_params[:process_number].to_i
      end
    end
end