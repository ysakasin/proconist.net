class ArticlesController < ApplicationController
  def index
    @articles = Article.published.all.order(created_at: :desc)
    @categories = ArticleCategory.all
  end

  def show
    @article = Article.published.find_by(url: params[:url])
    @articles = Article.published.all.order(created_at: :desc)
    @categories = ArticleCategory.all
  end
end
