# rubocop:disable Style/ClassAndModuleChildren

class Consoles::ArticleCategoriesController < Consoles::BaseController
  def index
    @categories = ArticleCategory.all.order(created_at: :desc)
  end

  def show
    @category = ArticleCategory.find(params[:id])
  end

  def new
    @category = ArticleCategory.new
  end

  def create
    category = ArticleCategory.create(category_params)
    flash[:status] = 'success'
    redirect_to show_category_console_path category
  end

  def update
    category = ArticleCategory.find(params[:id])
    category.update(category_params)
    flash[:status] = 'success'
    redirect_to show_category_console_path category
  end

  private

  def category_params
    params.require(:article_category).permit(:name, :url, :description)
  end
end
