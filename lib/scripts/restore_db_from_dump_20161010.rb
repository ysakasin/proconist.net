# restore data from production
# only articles and article_categories

require 'csv'
require 'logger'

DUMP_DIR = Rails.root.join('db', 'dump', '20160612')
logger = Logger.new(STDOUT)

logger.debug 'restore histories data'
histories = CSV.table(File.join(DUMP_DIR, 'histories.csv'))
histories.each do |history|
  History.create(
    label:      history[:label],
    title:      history[:title],
    url:        history[:href],
    image_path: history[:img]
  )
end
logger.debug 'finish restore histories data'
