class ReportsController < ApplicationController
  before_action :logged_in_user
  def index
    if params[:key]
      @month = params[:key][:month] 
      @item = params[:key][:item_id]
      # debugger 
    end
    # 降順に表示 (order( "DESC"))
    # 絞込みがあれば絞り込んで表示 　
    @reports = Report.all.search(@month, @item).order(day: "DESC").paginate(page: params[:page])
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
    Report.find(params[:id]).destroy
    flash[:success] = "処理記録を削除しました"
    redirect_to reports_path
  end

    private
      def report_params
        params.require(:report).permit(:user_id, :item_id, :process, :process_number,
                        :day, :purpose, :confirmer_id, :confirmation)
      end
end
