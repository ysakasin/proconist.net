class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order(created_at: :desc)
    @categories = ArticleCategory.all
  end

  def show
    @article = Article.find_by(url: params[:url])
    @articles = Article.all.order(created_at: :desc)
    @categories = ArticleCategory.all
  end
end
