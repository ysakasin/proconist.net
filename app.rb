# coding: utf-8
require 'bundler'
Bundler.require
require './model'
require './secret'

enable :sessions
set :session_secret, Secret::KEY

get '/' do
  @title = 'Proconist.net'
  contest_id = 25
  @contest = Contest.find_by_id(contest_id)

  entrants = Entrant.where(:contest => @contest.id)
  @competition = entrants.select {|item| item.competition?}
  @themed = entrants.select {|item| item.themed?}
  @original = entrants.select {|item| item.original?}

  @history = History.order("id desc").limit(5)
  @thumbnail = History.where(label: 1).order("id desc").limit(5)
  slim :index
end

get '/css/style.css' do
  sass :stylesheet, :style => :expanded
end

before '/sign_in' do
  redirect '/console/' if session[:op_id]
end

get '/sign_in' do
  slim :sign_in, :layout => :console_layout
end

post '/sign_in' do
  op = Operator.auth(params[:id], params[:password])
  if op
    session[:op_id] = op.id
    redirect '/console/'
  else
    redirect "/sign_in?status=error"
  end
end

get '/sign_out' do
  session[:op_id] = nil
  redirect '/sign_in'
end

before '/console/*' do
  unless session[:op_id] && Operator.exists?(id: session[:op_id])
    session[:op_id] = nil
    redirect '/sign_in'
  end
  @op = Operator.find_by_id(session[:op_id])
end

get '/console/' do
  slim :console
end
