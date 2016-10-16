# rubocop:disable Style/ClassAndModuleChildren

class Consoles::ArticlesController < Consoles::BaseController
  def index
    @articles = Article.includes(:article_categories).all.order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
    @article_categories = ArticleCategory.all
    @operators = Operator.all
  end

  def update
    article = Article.find(params[:id])
    fetched_params = article_params
    category_ids = fetched_params.delete(:article_categories)
    article.article_categories = ArticleCategory.where(id: category_ids)
    article.save
    article.update(fetched_params)
    flash[:status] = 'success'
    redirect_to show_article_console_path article
  end

  private

  def article_params
    params.require(:article).permit(
      :title,
      :url,
      :thumbnail_url,
      { article_categories: [] },
      :operator_id,
      :body
    )
  end
end
