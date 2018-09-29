class ContestsController < ApplicationController
  def index
    @contests = Contest.all.order(nth: :desc)
  end

  def show
    @contests = Contest.all.order(nth: :desc)
    @contest = Contest.includes(products: [:documents, :school, :prizes]).find_by(nth: params[:nth])
    @histories = History.order(id: :desc).limit(5)
    @histories_with_image = History.where.not(image_path: nil).where(label: 1).limit(5)
  end
end
