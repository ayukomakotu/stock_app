class ReportsController < ApplicationController
  before_action :logged_in_user
  def index
  # debugger
    if params[:key]
      @from = params[:key][:from] if params[:key][:from].present?
      @to = params[:key][:to] if params[:key][:to].present?
      @item = Item.find(params[:key][:item_id].to_i) if params[:key][:item_id].present?
      # debugger
    end
    # debugger 
    @items = Item.all
    # 降順に表示 (order( "DESC"))
    # 絞込みがあれば絞り込んで表示 　
    @reports = Report.all.search(@from, @to, @item).order(day: "DESC").paginate(page: params[:page])
    # 未入力のものがある場合flashが表示される
    uncomfirmed = @reports.map(&:confirmation).find { |com|com == false }
    flash.now[:danger] = "顧客管理ソフトへ未入力の処理が残っています" if uncomfirmed == false
    
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      redirect_to reports_path
    else
      render 'index'
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @item = @report.item
    @stock = @item.stock
    if @report.process == "出庫"
      @stock.update(number: @stock.number + @report.process_number)
    else 
      @stock.update(number: @stock.number - @report.process_number)
    end
    
    Report.find(params[:id]).destroy
    flash[:success] = "処理記録を削除しました"
    redirect_to reports_path, status: :see_other
  end

    private
      def report_params
        params.require(:report).permit(:user_id, :item_id, :process, :process_number,
                        :day, :purpose, :confirmer_id, :confirmation)
      end
end
