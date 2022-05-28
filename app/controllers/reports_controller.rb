class ReportsController < ApplicationController
  before_action :logged_in_user
  def index
    @reports = Report.all.paginate(page: params[:page])
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
