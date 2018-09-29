# rubocop:disable Style/NumericPredicate
# rubocop:disable Style/MultilineIfModifier

require 'sqlite3'

logger = Logger.new(STDOUT)

SQLite3::Database.new ARGV[0] do |dump|
  logger.debug 'migrate contents data'
  ActiveRecord::Base.transaction do
    dump.execute('select * from contests') do |row|
      Contest.create!(
        nth:                row[0],
        name:               row[1],
        date:               row[2],
        place:              row[3],
        title:              row[4],
        competition_title:  row[5],
        themed_title:       row[6]
      )
    end
  end
  logger.debug 'finish migrate contests data'

  logger.debug 'migrate products, documents, prizes(entrants) data'
  ActiveRecord::Base.transaction do
    dump.execute('select * from entrants') do |row|
      product = Product.create!(
        contest_id: Contest.find_by(nth: row[1]).id,
        section:    row[2],
        school_id:  School.find_or_create_by(name: row[4]).id,
        name:       row[5],
        rank:       row[14]
      )
      document_hash = {
        github:       row[6],
        bitbucket:    row[7],
        other_repo:   row[8],
        slideshare:   row[9],
        other_slide:  row[10],
        twitter:      row[11],
        facebook:     row[12],
        site:         row[13]
      }
      document_hash.each do |k, v|
        Document.create!(
          product_id:     product.id,
          document_type:  k,
          url:            v
        ) if v.present?
      end
      if row[15].present?
        row[15].split(',').each do |prize|
          Prize.create!(
            product_id: product.id,
            name:       prize
          )
        end
      end
    end
  end
  logger.debug 'finish migrate products, documents, prizes(entrants) data'

  logger.debug 'migrate operators(operators) data'
  ActiveRecord::Base.transaction do
    dump.execute('select * from operators') do |row|
      Operator.create!(
        identifier:       row[1],
        position:         row[2],
        name:             row[3],
        password_digest:  row[4],
        icon:         row[6].gsub('/img', 'operators'),
        school_id:    School.find_or_create_by(name: row[7]).id,
        github:       (row[8].present? ? "https://github.com/#{row[8]}" : nil),
        bitbucket:    (row[9].present? ? "https://bitbucket.org/#{row[9]}/" : nil),
        slideshare:   (row[10].present? ? "https://www.slideshare.net/#{row[10]}" : nil),
        twitter:      (row[11].present? ? "https://twitter.com/#{row[11]}" : nil),
        facebook:     (row[12].present? ? "https://www.facebook.com/#{row[12]}" : nil),
        site:         row[13].presence,
        description:  row[14],
        email:        row[15]
      )
    end
  end
  logger.debug 'finish migrate operators data'

  logger.debug 'migrate article_categories(categories) data'
  ActiveRecord::Base.transaction do
    dump.execute('select * from categories') do |row|
      ArticleCategory.create!(
        url:          row[1],
        name:         row[2],
        description:  row[2]
      )
    end

    dump.execute('select * from articles') do |row|
      article = Article.create!(
        url:            row[1],
        title:          row[2],
        body:           row[3],
        operator_id:    Operator.find_by(identifier: row[5]).id,
        thumbnail_url:  row[6].gsub('/img/', ''),
        published_at:   Time.zone.now
      )
      article.article_categories << ArticleCategory.first
      article.save!
    end
  end
  logger.debug 'finish migrate article_categories data'

  logger.debug 'migrate histories data'
  ActiveRecord::Base.transaction do
    dump.execute('select * from histories') do |row|
      if row[1] == 0
        product = Product.find_by(name: /.+「(.+)」/.match(row[2])[1])
        url = "/contest/#{product.contest.nth}##{product.section_name}-#{product.id}"
        History.create!(
          label:      row[1],
          title:      row[2],
          url:        url,
          image_path: (row[4].present? ? row[4].gsub('/img/', '') : nil)
        )
      else
        History.create!(
          label:      row[1],
          title:      row[2],
          url:        row[3],
          image_path: (row[4].present? ? row[4].gsub('/img/', '') : nil)
        )
      end
    end
  end
  logger.debug 'finish migrate histories data'

  logger.debug 'migrate reports data'
  ActiveRecord::Base.transaction do
    dump.execute('select * from reports') do |row|
      Report.create!(
        contest_id:     Contest.find_by(nth: row[1]).id,
        section:        row[2],
        product_name:   row[3],
        email:          row[4],
        repository_url: row[5],
        slide_url:      row[6],
        site_url:       row[7],
        twitter:        row[8],
        facebook:       row[9],
        comment:        row[10]
      )
    end
  end
  logger.debug 'finish migrate reports data'

end
