class ReportsController < ApplicationController
  before_action :logged_in_user
  def index
    @reports = Report.all.order(day: "DESC").paginate(page: params[:page])
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

      # パラメータによって、入庫、出庫などの処理によってフラッシュメッセージを使い分ける
      def update_flash
        if params[:commit] == "未入力"
          flash[:success] = "顧客管理ソフトへの入力を確認しました"
        elsif params[:commit] == "入力済"
          flash[:success] = "顧客管理ソフトへの入力を未入力に戻しました"
        else
          flash[:success] = "履歴を編集しました"
        end
      end
end
