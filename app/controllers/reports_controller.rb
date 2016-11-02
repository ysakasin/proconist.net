# rubocop:disable Metrics/MethodLength

class ReportsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @contests = Contest.all
    @report = Report.new
    @sections_enum = { '競技部門': 0, '課題部門': 1, '自由部門': 2 }.freeze
  end

  def create
    @report = Report.new(report_params)
    respond_to do |format|
      if @report.save
        send_all_operator
        format.html { redirect_to report_thankyou_path }
      else
        format.html { redirect_to report_path }
      end
    end
  end

  def thankyou
  end

  private

  def report_params
    params.require(:report).permit(
      :contest_id,
      :section,
      :product_name,
      :email,
      :repository_url,
      :slide_url,
      :site_url,
      :twitter,
      :facebook,
      :comment
    )
  end

  def send_all_operator
    Operator.all.each do |operator|
      ReportMailer.receive_report_email(operator, @report).deliver_later
    end
  end
end
