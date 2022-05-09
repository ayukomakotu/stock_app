class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id])
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

  private
    def item_params
      params.require(:item).permit(:name, :unit)
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
