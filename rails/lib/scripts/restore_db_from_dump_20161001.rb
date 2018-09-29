# restore data from production
# only articles and article_categories

require 'csv'
require 'logger'

DUMP_DIR = Rails.root.join('db', 'dump', '20160612')
logger = Logger.new(STDOUT)

logger.debug 'restore article_categories data'
categories = CSV.table(File.join(DUMP_DIR, 'categories.csv'))
categories.each do |category|
  ArticleCategory.create(
    url:          category[:url],
    name:         category[:name],
    description:  category[:description] || 'お知らせです'
  )
end
logger.debug 'finish restore article_categories data'

logger.debug 'restore articles data'
articles = CSV.table(File.join(DUMP_DIR, 'articles.csv'))
articles.each do |article|
  Article.create(
    url:            article[:url],
    title:          article[:title],
    body:           article[:body],
    category_id:    ArticleCategory.first.id,
    operator_id:    Operator.first.id,
    thumbnail_url:  article[:thumbnail]
  )
end
logger.debug 'finish restore articles data'
