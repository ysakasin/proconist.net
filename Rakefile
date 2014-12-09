require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './model.rb'

desc '開発モードでSinatraを実行する'
task :dev_exec do
  sh 'export DB=dev.db; ruby app.rb'
end

desc '作品の情報を登録'
task :add_product do
  entrant = Entrant.new
  Entrant.column_names.each do |name|
    next if name == 'id'
    print "#{Entrant.send(name.pluralize)}\n" if Entrant::ENUMS.include?(name)
    print "#{name}:"
    val = STDIN.gets.chomp
    entrant.send("#{name}=", val) if val.present?
  end
  entrant.save
end

desc '大会の情報を登録'
task :add_contest do
  contest = Contest.new
  Contest.column_names.each do |name|
    print "#{name}:"
    val = STDIN.gets.chomp
    next if val.blank?
    contest[name] = val
  end
  contest.save
end

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

desc '管理者のログイン情報やプロフィールなどを登録'
task :add_op do
  print 'id:'
  id = STDIN.gets.chomp
  fail 'IdDuplication' if Operator.where(id: id).exists?
  operator = Operator.new
  operator['id'] = id
  operator.position = 'admin' if ENV['ADMIN'] == 'true'

  begin
    print 'password:'
    pass = STDIN.noecho(&:gets).chomp
    print "\nconfirm password:"
    conf = STDIN.noecho(&:gets).chomp
    print "\n"
  end while pass.blank? || pass != conf
  operator.encrypt_password(pass)

  Operator.column_names.each do |name|
    next if ['id', 'position', 'password_hash', 'password_salt'].include?(name)
    print "#{name}:"
    val = STDIN.gets.chomp
    operator.send("#{name}=", val) if val.present?
  end
  operator.save
end

task :show do
  Entrant.all.each do |e|
    p e
  end
  Contest.all.each do |c|
    p c
  end
  Operator.all.each do |o|
    p o
  end
end
