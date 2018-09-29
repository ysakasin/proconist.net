# rubocop:disable Style/ClassAndModuleChildren

class Consoles::ReportsController < Consoles::BaseController
  def index
    @reports = Report.includes(:contest).all.order(created_at: :desc)
  end

  def show
    @report = Report.includes(:contest).find(params[:id])
  end

  def destroy
    Report.find(params[:id]).destroy
    redirect_to console_report_path
  end
end
