namespace :contest do

  SECTIONS = {
    'competition section' => 0,
    'themed section' => 1,
    'original section' => 2
  }.freeze

  # rake contest:import JSON=/path/to/json
  desc 'JSONファイルから作品情報を読み込む'
  task import: :environment do
    File.open(ENV['JSON']) do |file|
      text = file.read
      json = JSON.parse(text)

      contest_data = json.delete('contest')
      nth = contest_data.delete('id')
      contest_data['nth'] = nth

      contest = Contest.create(contest_data)

      json.each do |section_name, section_data|
        section_id = SECTIONS[section_name]

        section_data.each do |product_data|
          school = School.find_or_create_by(name: product_data['school name'])
          product = Product.create(
            contest_id: contest.id,
            section: section_id,
            school_id: school.id,
            name: product_data['title']
          )

          prizes = product['prize'] || []
          prizes.each do |prize_name|
            Prize.create(
              product_id: product.id,
              name: prize_name
            )
          end
        end
      end
    end
  end
end
