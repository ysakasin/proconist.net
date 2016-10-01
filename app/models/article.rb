require 'redcarpet/render_strip'

class TargetBlankRenderer < Redcarpet::Render::HTML
  def initialize(extensions = {})
    super extensions.merge(link_attributes: { target: '_blank' })
  end
end

class Article < ApplicationRecord
  belongs_to :category, class_name: :ArticleCategory
  belongs_to :operator

  def body_html
    Redcarpet::Markdown.new(TargetBlankRenderer).render(body)
  end

  def description(limit = 90, after = '...')
    Redcarpet::Markdown.new(Redcarpet::Render::StripDown).render(body)[0, limit] + after
  end

  def date
    created_at.strftime('%Y年%m月%d日')
  end
end
