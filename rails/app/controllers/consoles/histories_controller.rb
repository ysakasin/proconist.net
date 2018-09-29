# rubocop:disable Style/ClassAndModuleChildren

class Consoles::HistoriesController < Consoles::BaseController
  def index
    @histories = History.all.order(created_at: :desc)
  end

  def new
    @history = History.new
  end

  def create
    history = History.create(history_params)
    flash[:status] = 'success'
    redirect_to show_history_console_path history
  end

  def show
    @history = History.find(params[:id])
  end

  def destroy
    History.find(params[:id]).destroy!
    redirect_to console_history_path
  end

  def update
    history = History.find(params[:id])
    history.update!(history_params)
    flash[:status] = 'success'
    redirect_to show_history_console_path history
  end

  private

  def history_params
    params.require(:history).permit(:label, :url, :title, :image_path)
  end
end
