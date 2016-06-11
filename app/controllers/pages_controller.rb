class PagesController < ApplicationController

  def index
    @contest = Contest.last
  end

  def about
  end

end
