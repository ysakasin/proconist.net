# restore data from production
# only contest, products(entrant), document
# and create school

require 'csv'
require 'logger'

DUMP_DIR = Rails.root.join('db', 'dump', '20160612')
logger = Logger.new(STDOUT)

logger.debug 'restore prizes data'
entrants = CSV.table(File.join(DUMP_DIR, 'entrants.csv'))
entrants.each do |entrant|
  p = Product.find_by(
    contest_id: Contest.find_by(nth: entrant[:contest]).id,
    section:    entrant[:section],
    school_id:  School.find_by(name: entrant[:school]).id,
    name:       entrant[:production],
    rank:       entrant[:result]
  )
  if p && entrant[:prize].present?
    entrant[:prize].split(',').each do |prize|
      Prize.create!(
        product_id: p.id,
        name:       prize
      )
    end
  end
end
logger.debug 'finish restore prizes data'
