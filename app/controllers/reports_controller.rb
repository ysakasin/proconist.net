class ReportsController < ApplicationController
  def index
    @contests = Contest.all
    @report = Report.new
    @sections_enum = { '競技部門': 0, '課題部門': 1, '自由部門': 2 }.freeze
  end
end
