class ContestsController < ApplicationController
  def index
    @contests = Contest.all.order(nth: :desc)
  end
end
