class ReportsController < ApplicationController
  before_action :logged_in_user
  def index
    @month = params[:month] if params[:month]
    # 降順に表示
    if @month
      @reports = Report.month_between(@month).order(day: "DESC").paginate(page: params[:page])
    else
      @reports = Report.all.order(day: "DESC").paginate(page: params[:page])
    end

    # 未入力のものがある場合flashが表示される
    uncomfirmed = @reports.map(&:confirmation).find { |com|com == false }
    flash.now[:danger] = "顧客管理ソフトへ未入力の処理が残っています" if uncomfirmed == false
    
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      redirect_to reports_path
    else
      render 'index'
    end
  end

    private
      def report_params
        params.require(:report).permit(:user_id, :item_id, :process, :process_number,
                        :day, :purpose, :confirmer_id, :confirmation)
      end
end
