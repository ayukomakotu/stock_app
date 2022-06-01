class StocksController < ApplicationController
  before_action :logged_in_user
  
  def edit
    @stock = Stock.find(params[:id])
    @item = @stock.item
    @stock_form = StockForm.new
  end

  def update
    @stock = Stock.find(params[:id])
    @item = Item.find(@stock.item_id)
    @stock_form = StockForm.new(stock_form_params)
    # presentはnil, "", " ", [], {}でなければtrueを返す
    if params[:stock_form][:process_number].present?
      if @stock.update(number: new_stock)
        @stock_form.save
        update_flash
        redirect_to items_path
      else
        # render先にパラメータとしてprocess_name: params[:commit]を送信
        # stocks/editで入庫と出庫の切り替わりができるようにパラメータを渡す
        render 'edit'
        # エラーメッセージ、flash必要？
      end
    else
      flash[:danger] = "正しい数値を入力してください（0と空白は入力できません）"
      render 'edit'
    end
  end

  private
    # def stock_params
    #   params.require(:stock).permit(:process_number)
    # end

    def stock_form_params
      params.require(:stock_form).permit(:day, :process, :process_number, :purpose, 
                                                :number, :item_id, :user_id, :id)
    end

    # 入出庫の計算　出庫ならstockからprocess_numberをひいた値を返す、入庫なら足した値を返す
    def new_stock
      if params[:commit] == "出庫"
        @stock.number - stock_form_params[:process_number].to_i
      elsif params[:commit] == "入庫"
        @stock.number + stock_form_params[:process_number].to_i
      end
    end

    # パラメータによって、入庫、出庫などの処理によってフラッシュメッセージを使い分ける
    def update_flash
      process_word = "#{@item.name}を#{stock_form_params[:process_number]}#{@item.unit}"
      if params[:commit] == "出庫"
        flash[:success] = process_word + "出庫しました"
      elsif params[:commit] == "入庫"
        flash[:success] =  process_word + "入庫しました"
      end
    end


    

    
end
