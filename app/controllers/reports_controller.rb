class ReportsController < ApplicationController
  def index
    @reports = Report.all.paginate(page: params[:page])
  end
end
