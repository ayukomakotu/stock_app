class ReportsController < ApplicationController
  def index
    @reports = Report.all.paginate(page: params[:page])
  end

  def update
    @report = Report.find(params[:id])
    # 入力確認　入力済み　未入力の切り替え
    if params[:report][:confirmation] == "toggle"
      @report.toggle!(:confirmation)
      redirect_to reports_path
    else
      # 通常のアップデート
      if @report.update(report_params)
        redirect_to reports_path
      else
        render 'index' 
      end
    end
  end

    private
      def report_params
        params.require(:report).permit(:user_id, :item_id, :process, :process_number,
                        :day, :purpose, :confirmer_id, :confirmation)
      end
end
