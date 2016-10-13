class PagesController < ApplicationController

  def index
    @contest = Contest.last
    @contests = Contest.all.order(nth: :desc)
    @histories = History.all.order(created_at: :desc)
    @histories_with_image = History.where.not(image_path: nil).where(label: 1).limit(5)
  end

  def about
  end

end
