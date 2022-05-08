class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def edit
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "編集が完了しました"
      redirect_to items_path
    else
      render 'edit'
    end
      
  end
  
  def out_stock
    @item = Item.find(params[:id])
  end

  private
    def item_params
      params.require(:item).permit(:id, :name, :stock, :unit, :process_number)
    end

    # item_params[:stock]を出庫ならマイナス入庫ならプラスしたものを返す、その他編集ならitem_paramsを返す
    # mergeメソッドでitem_paramsの値を変更したものをnew_item_paramsとして返す
    def new_item_params
      if params[:commit] == "出庫"
        new_stock = (item_params[:stock].to_i - item_params[:process_number].to_i).to_s
        item_params.merge(:stock => new_stock)
      elsif params[:commit] == "入庫"
        new_stock = (item_params[:stock].to_i + item_params[:process_number].to_i).to_s
        item_params.merge(:stock => new_stock)
      else
        item_params
      end
    end

    # パラメータによって、入庫、出庫などの処理によってフラッシュメッセージを使い分ける
    def update_flash
      process_word = "#{@item.name}を#{item_params[:process_number]}#{@item.unit}"
      if params[:commit] == "出庫"
        flash[:success] = process_word + "出庫しました"
      elsif params[:commit] == "入庫"
        flash[:success] =  process_word + "入庫しました"
      else
        flash[:success] = "編集が完了しました"
      end
    end

    # パラメータによって、入庫、出庫などの処理によってrender先が変わる
    def render_form
      if params[:commit] == "出庫"
        render 'out_stock'
      elsif
        params[:commit] == "入庫"
        render 'in_stock'
      else
        render 'edit'
      end
    end

end
