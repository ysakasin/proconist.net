class OperatorsController < ApplicationController
  def show
    @operator = Operator.includes(articles: [:article_categories]).find_by(identifier: params[:identifier])
    @title = @operator.name
  end
end
