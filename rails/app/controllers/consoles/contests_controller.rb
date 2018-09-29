# rubocop:disable Style/ClassAndModuleChildren
# rubocop:disable Style/EmptyMethod

class Consoles::ContestsController < Consoles::BaseController
  def index
    @contests = Contest.all.order(nth: :desc)
  end

  def new
    @contest = Contest.new
  end

  def create
    contest = Contest.create(contest_params)
    flash[:status] = 'success'
    redirect_to edit_contest_console_path contest.nth
  end

  def edit
    @contest = Contest.find_by(nth: params[:nth])
  end

  def show
  end

  def update
    contest = Contest.find_by(nth: params[:contest][:nth])
    contest.update!(contest_params)
    flash[:status] = 'success'
    redirect_to edit_contest_console_path contest.nth
  end

  private

  def contest_params
    params.require(:contest).permit(:nth, :name, :date, :place, :title, :competition_title, :themed_title)
  end
end
