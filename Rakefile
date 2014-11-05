require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './model.rb'

task :add do
  entrant = Entrant.new
  Entrant.column_names.each do |name|
    next if name == 'id'
    print "#{Entrant.send(name.pluralize)}\n" if Entrant::ENUMS.include?(name)
    print "#{name}:"
    val = STDIN.gets.chomp
    next if val.blank?
    entrant[name] = val
  end
  entrant.save
end

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

task :show do
  Entrant.all.each do |e|
    p e
  end
  Contest.all.each do |c|
    p c
  end
end
