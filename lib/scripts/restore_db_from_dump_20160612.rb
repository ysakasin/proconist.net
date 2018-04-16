# restore data from production
# only contest, products(entrant), document
# and create school

require 'csv'
require 'logger'

DUMP_DIR = Rails.root.join('db', 'dump', '20160612')
logger = Logger.new(STDOUT)

logger.debug 'restore contents data'
contests = CSV.table(File.join(DUMP_DIR, 'contests.csv'))
contests.each do |contest|
  Contest.create!(
    name:               contest[:name],
    date:               contest[:date],
    place:              contest[:place],
    title:              contest[:title],
    competition_title:  contest[:competition_title],
    themed_title:       contest[:themed_title],
    nth:                contest[:id]
  )
end
logger.debug 'finish restore contests data'

logger.debug 'restore products(entrants) data'
entrants = CSV.table(File.join(DUMP_DIR, 'entrants.csv'))
entrants.each do |entrant|
  p = Product.create!(
    contest_id: Contest.find_by(nth: entrant[:contest]).id,
    section:    entrant[:section],
    school_id:  School.find_or_create_by!(name: entrant[:school]).id,
    name:       entrant[:production],
    rank:       entrant[:result]
  )

  %i[github bitbucket other_repo slideshare other_slide twitter facebook site].each do |doc|
    if entrant[doc].present?
      Document.create!(
        product_id:     p.id,
        document_type:  doc.to_s,
        url:            entrant[doc]
      )
    end
  end
end
logger.debug 'finish restore products(entrants) data'
