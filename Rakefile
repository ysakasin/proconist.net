require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './model.rb'

task :add do
  entrant = Entrant.new
  columns = Entrant.column_names
  columns.each do |name|
    next if name == 'id'
    if Entrant::ENUMS.include?(name)
      print "#{Entrant.send(name.pluralize)}\n"
    end
    print "#{name}:"
    val = STDIN.gets.chomp
    next if val.blank?
    entrant[name] = val
  end
  entrant.save
end

task :show do
  Entrant.all.each do |e|
    p e
  end
end
