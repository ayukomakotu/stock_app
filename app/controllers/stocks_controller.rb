class StocksController < ApplicationController
  def edit
    @stock = Stock.find(params[:id])
  end

  def update
    @stock = Stock.find(params[:id])
    @item = Item.find(@stock.item_id)
    # presentはnil, "", " ", [], {}でなければtrueを返す
    if params[:stock][:process_number].present?
      if @stock.update(number: new_stock)
        update_flash
        redirect_to items_path
      else
        # render先にパラメータとしてprocess_name: params[:commit]を送信
        # stocks/editで入庫と出庫の切り替わりができるようにパラメータを渡す
        render 'edit'
        # エラーメッセージ、flash必要？
      end
    else
      render 'edit'
    end
  end

  private
    def stock_params
      params.require(:stock).permit(:process_number)
    end

    # 入出庫の計算　出庫ならstockからprocess_numberをひいた値を返す、入庫なら足した値を返す
    def new_stock
      if params[:commit] == "出庫"
        @stock.number - stock_params[:process_number].to_i
      elsif params[:commit] == "入庫"
        @stock.number + stock_params[:process_number].to_i
      end
    end

    # パラメータによって、入庫、出庫などの処理によってフラッシュメッセージを使い分ける
    def update_flash
      process_word = "#{@item.name}を#{stock_params[:process_number]}#{@item.unit}"
      if params[:commit] == "出庫"
        flash[:success] = process_word + "出庫しました"
      elsif params[:commit] == "入庫"
        flash[:success] =  process_word + "入庫しました"
      end
    end


    

    
end
