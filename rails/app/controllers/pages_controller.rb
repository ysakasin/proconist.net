class PagesController < ApplicationController

  def index
    @contest = Contest.last
    @contests = Contest.includes(products: [:documents]).all.order(nth: :desc)
    @histories = History.order(id: :desc).limit(5)
    @histories_with_image = History.where.not(image_path: nil).where(label: 1).limit(5)
  end

  def about
    @operators = Operator.all
  end

end
