class ItemsController < ApplicationController
before_action :logged_in_user

  def index
    @items = Item.all
  end

  def new
    @item_form = ItemForm.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    if @item_form.valid?
      @item_form.save
      flash[:success] = "新しい在庫品を登録しました"
      redirect_to items_path
    else
      render "new"
    end
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
    def item_form_params
      params.require(:item_form).permit(:name, :unit, :number)
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
