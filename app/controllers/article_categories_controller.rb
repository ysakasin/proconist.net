class ArticleCategoriesController < ApplicationController
  def show
    @articles = Article.all.order(created_at: :desc)
    @category = ArticleCategory.includes(:articles).find_by(url: params[:url])
    @categories = ArticleCategory.all
  end
end
