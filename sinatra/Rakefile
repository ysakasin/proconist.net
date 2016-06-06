require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './model.rb'

# rake load_json JSON=/path/to/json
desc 'JSONファイルから作品情報を読み込む'
task :load_json do
  section_num = {"competition section" => 0, "themed section" => 1, "original section" => 2}
  File.open(ENV['JSON']) do |file|
    text = file.read
    json = JSON.parse(text)

    contest = json.delete('contest')
    Contest.create(contest)

    json.each do |key, section|
      section.each do |product|
        prizes = product['prize'] || []
        Entrant.create(
        contest: contest['id'],
        section: section_num[key],
        school: product['school name'],
        registry_num: product['id'],
        production: product['title'],
        prize: prizes.join(',')
        )
      end
    end
  end
end

# rake add_history
desc '更新情報を登録'
task :add_history do
  history = History.new
  History.column_names.each do |name|
    next if ['id', 'created_at', 'updated_at'].include?(name)
    print "#{History.send(name.pluralize)}\n" if History::ENUMS.include?(name)
    print "#{name}:"
    val = STDIN.gets.chomp
    history.send("#{name}=", val) if val.present?
  end
  history.save
end

# rake add_op [ADMIN=true]
desc '管理者のログイン情報を登録'
task :add_op do
  print 'id:'
  id = STDIN.gets.chomp
  fail 'IdDuplication' if Operator.where(id: id).exists?
  operator = Operator.new
  operator.op_id = id
  operator.name = id
  operator.position = 'admin' if ENV['ADMIN'] == 'true'

  print 'password:'
  pass = STDIN.noecho(&:gets).chomp
  print "\nconfirm password:"
  conf = STDIN.noecho(&:gets).chomp

  if pass.present? && pass == conf
    operator.encrypt_password(pass)
    operator.save
    print "\nSaved.\n"
  else
    print "\nError.\n"
  end
end
