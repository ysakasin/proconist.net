# rubocop:disable Style/ClassAndModuleChildren
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

class Consoles::ProductsController < Consoles::BaseController
  def index
    @contests = Contest.all.order(nth: :desc)
  end

  def list
    @contest = Contest.find_by(nth: params[:nth])
    @products = @contest.products
  end

  def new
    @product = Product.find_by(id: params[:id])
    @contests = Contest.all.order(nth: :desc)
    @schools = School.all
  end

  def create
    product = build_from_params(Product.new)
    flash[:status] = 'success'
    redirect_to show_product_console_path(product)
  end

  def show
    @product = Product.find_by(id: params[:id])
    @contests = Contest.all.order(nth: :desc)
    @schools = School.all
    @documents = @product.documents
    @github     = @documents.githubs.first || Document.new(product_id: @product.id, document_type: 'github')
    @bitbucket  = @documents.bitbuckets.first || Document.new(product_id: @product.id, document_type: 'bitbucket')
    @other_repo = @documents.other_repos.first || Document.new(product_id: @product.id, document_type: 'other_repo')
    @slideshare = @documents.slideshares.first || Document.new(product_id: @product.id, document_type: 'slideshare')
    @other_slide = @documents.other_slides.first || Document.new(product_id: @product.id, document_type: 'other_slide')
    @site       = @documents.sites.first || Document.new(product_id: @product.id, document_type: 'site')
    @twitter    = @documents.twitters.first || Document.new(product_id: @product.id, document_type: 'twitter')
    @facebook   = @documents.facebooks.first || Document.new(product_id: @product.id, document_type: 'facebook')
  end

  def update
    product = build_from_params Product.find(params[:id])
    flash[:status] = 'success'
    redirect_to show_product_console_path(product)
  end

  private

  def product_params
    params.permit(
      product: [
        :contest_id,
        :section,
        :school_id,
        :name,
        :rank
      ],
      github: :url,
      bitbucket: :url,
      other_repo: :url,
      slideshare: :url,
      other_slide: :url,
      site: :url,
      twitter: :url,
      facebook: :url,
      prize: :name,
      history: :update
    )
  end

  def build_from_params(product)
    ActiveRecord::Base.transaction do
      product.update!(product_params[:product])
      %w(github bitbucket other_repo slideshare other_slide site twitter facebook).each do |doc_type|
        document = product.documents.find_by(document_type: doc_type)
        if document.present? && product_params[doc_type][:url].present?
          document.update!(product_params[doc_type])
        elsif document.blank? && product_params[doc_type][:url].present?
          Document.create(
            product_id:     product.id,
            url:            product_params[doc_type][:url],
            document_type:  doc_type
          )
        end
      end
      product_params[:prize][:name].split(',').each do |prize|
        product.prizes.find_or_create_by(name: prize)
      end
      if product_params[:history][:update] == '1'
        History.create(
          label:  0,
          title:  "#{product.section_name_ja} #{product.school.name} 「#{product.name}」",
          url:    show_contest_path(product.contest.nth) + "##{product.section_name}-#{product.id}"
        )
      end
    end
    product
  end
end
