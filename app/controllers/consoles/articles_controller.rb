# rubocop:disable Style/ClassAndModuleChildren

class Consoles::ArticlesController < Consoles::BaseController
  def index
    @articles = Article.includes(:article_categories).published.order(created_at: :desc)
    @drafts = Article.includes(:article_categories).in_draft.order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
    @article_categories = ArticleCategory.all
    @operators = Operator.all
  end

  def new
    @article = Article.new
    @article_categories = ArticleCategory.all
    @operators = Operator.all
  end

  def create
    article = Article.new
    fetched_params = article_params
    category_ids = fetched_params.delete(:article_categories)
    article.article_categories = ArticleCategory.where(id: category_ids)
    published_check = fetched_params.delete(:publish)
    article.published_at = Time.zone.now if published_check == '1'
    article.save
    article.update(fetched_params)
    flash[:status] = 'success'
    redirect_to show_article_console_path article
  end

  def update
    article = Article.find(params[:id])
    fetched_params = article_params
    category_ids = fetched_params.delete(:article_categories)
    change_article_status article, fetched_params.delete(:publish)
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
      :body,
      :publish
    )
  end

  def change_article_status(article, check_box_value)
    article.published_at = Time.zone.now if article.draft? && check_box_value == '1'
    article.published_at = Time.zone.parse('2200-12-31') if article.published? && check_box_value == '0'
    article
  end
end
