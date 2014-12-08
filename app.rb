# coding: utf-8
require 'bundler'
Bundler.require
require './model'

get '/' do
  @title = 'Proconist.net'
  contest_id = 25
  @contest = Contest.find_by_id(contest_id)
  entrants = Entrant.where(:contest => @contest.id)
  @competition = entrants.select {|item| item.competition?}
  @themed = entrants.select {|item| item.themed?}
  @original = entrants.select {|item| item.original?}
  slim :index
end

get '/css/style.css' do
  sass :stylesheet, :style => :expanded
ends
