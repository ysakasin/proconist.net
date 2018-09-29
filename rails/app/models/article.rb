# rubocop:disable Rails/HasAndBelongsToMany

require 'redcarpet/render_strip'

class TargetBlankRenderer < Redcarpet::Render::HTML
  def initialize(extensions = {})
    super extensions.merge(link_attributes: { target: '_blank' })
  end
end

class Article < ApplicationRecord
  has_and_belongs_to_many :article_categories
  belongs_to :operator

  scope :published, -> { where('published_at <  ?', Time.zone.now) }
  scope :in_draft,  -> { where('published_at >  ?', Time.zone.now) }

  def body_html
    Redcarpet::Markdown.new(TargetBlankRenderer).render(body)
  end

  def description(limit = 90, after = '...')
    Redcarpet::Markdown.new(Redcarpet::Render::StripDown).render(body)[0, limit] + after
  end

  def date
    created_at.strftime('%Y年%m月%d日')
  end

  def published?
    published_at < Time.zone.now
  end

  def draft?
    !published?
  end
end
