class ContestsController < ApplicationController
  def index
    @contests = Contest.all.order(nth: :desc)
  end

  def show
    @contests = Contest.all.order(nth: :desc)
    @contest = Contest.eager_load(:products).find_by(nth: params[:nth])
  end
end
