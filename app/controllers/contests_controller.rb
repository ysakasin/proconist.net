class ContestsController < ApplicationController
  def index
    @contests = Contest.all.order(nth: :desc)
  end

  def show
    @contests = Contest.all.order(nth: :desc)
    @contest = Contest.eager_load(:products).find_by(nth: params[:nth])
    @histories = History.all.order(created_at: :desc)
    @histories_with_image = History.where.not(image_path: nil).where(label: 1).limit(5)
  end
end
