# coding: utf-8
require 'bundler'
Bundler.require
require './model'
require './secret'

enable :sessions
set :session_secret, Secret::KEY

helpers do
  def option_tag(label, val, selected=false)
    if selected
      "<option value=\"#{val}\" selected>#{label}</option>"
    else
      "<option value=\"#{val}\">#{label}</option>"
    end
  end
end

get '/' do
  @title = 'Proconist.net'
  contest_id = 1
  @contest = Contest.find_by_id(contest_id)

  entrants = Entrant.where(:contest => @contest.id)
  @competition = entrants.select {|item| item.competition?}
  @themed = entrants.select {|item| item.themed?}
  @original = entrants.select {|item| item.original?}

  @history = History.order("id desc").limit(5)
  @thumbnail = History.where(label: 1).order("id desc").limit(5)
  erb :index
end

get '/css/style.css' do
  sass :stylesheet, :style => :expanded
end

get '/about' do
  @member = Operator.all
  erb :about
end

get '/contest/:id' do |id|
  @contest = Contest.find_by_id(id)

  entrants = Entrant.where(:contest => @contest.id)
  @competition = entrants.select {|item| item.competition?}
  @themed = entrants.select {|item| item.themed?}
  @original = entrants.select {|item| item.original?}

  @history = History.order("id desc").limit(5)
  @thumbnail = History.where(label: 1).order("id desc").limit(5)
  erb :contest
end

get '/entry' do
  @entries = Article.order("id desc").limit(5)
  @entry_total = Article.all.size
  erb :entries
end

get '/entry/page/:p' do
  redirect '/entry' if params[:p] == '1'
  @entries = Article.order("id desc").limit(5).offset((params[:p].to_i - 1) * 5)
  @entry_total = Article.all.size
  erb :entries
end

get '/entry/:title' do
  @entry = Article.find_by_url(params[:title])
  erb :entry
end

get '/category/:c' do
  @category = Category.find_by_url(params[:c])
  @entries = Article.where(id: @category.entry_id(1))
  erb :category
end

get '/category/:c/:p' do
  redirect "/category/params[:c]" if params[:p] == '1'
  @category = Category.find_by_url(params[:c])
  @entries = Article.where(id: @category.entry_id(params[:p].to_i))
  erb :category
end

get '/auther/:op' do
  @auther = Operator.find_by_op_id(params[:op])
  erb :auther
end

before '/sign_in' do
  redirect '/console' if session[:op_id]
end

get '/sign_in' do
  erb :sign_in, :views => 'views/console', :layout => false
end

post '/sign_in' do
  op = Operator.auth(params[:id], params[:password])
  if op
    session[:op_id] = op.op_id
    redirect '/console'
  else
    redirect "/sign_in?status=error"
  end
end

get '/sign_out' do
  session[:op_id] = nil
  redirect '/sign_in'
end

before '/console*' do
  redirect '/sign_in' if session[:op_id].blank?

  @op = Operator.find_by_op_id(session[:op_id])
  if @op.blank?
    session[:op_id] = nil
    redirect '/sign_in'
  end
end

get '/console' do
  erb :index, :views => 'views/console'
end

get '/console/contest' do
  @contests = Contest.all
  erb :contest, :views => 'views/console'
end

get '/console/contest/new' do
  @contest = Contest.new
  erb :contest_edit, :views => 'views/console'
end

post '/console/contest/new' do
  @contest = Contest.new(id: params[:id].to_i)
  Contest.columns.each do |col|
    @contest.send("#{col.name}=", params[col.name])
  end
  @contest.save
  redirect "/console/contest/#{params[:id]}?status=success"
end

get '/console/contest/:id' do
  @contest = Contest.find_by_id(params[:id].to_i)
  erb :contest_edit, :views => 'views/console'
end

post '/console/contest/:id' do
  @contest = Contest.find_by_id(params[:id].to_i)
  Contest.columns.each do |col|
    @contest.send("#{col.name}=", params[col.name])
  end
  @contest.save
  redirect "/console/contest/#{params[:id]}?status=success"
end

get '/console/entrant' do
  @contests = Contest.all
  erb :entrant, :views => 'views/console'
end

get '/console/entrant/contest/:id' do
  @entrants = Entrant.where(:contest => params[:id])
  erb :entrant_list, :views => 'views/console'
end

get '/console/entrant/:id' do
  @entrant = Entrant.find_by_id(params[:id].to_i)
  erb :entrant_edit, :views => 'views/console'
end

post '/console/entrant/:id' do
  @entrant = Entrant.find_by_id(params[:id].to_i)
  Entrant.columns.each do |col|
    p col.name
    @entrant.send("#{col.name}=", params[col.name])
  end
  @entrant.save
  redirect "/console/entrant/#{params[:id]}?status=success"
end

get '/console/user-settings' do
  erb :user_settings, :views => 'views/console'
end

post '/console/user-settings' do
  cols = [:name, :school, :github, :bitbucket, :slideshare, :twitter, :facebook, :site, :description]
  cols.each do |col|
    @op.send("#{col}=", params[col])
  end
  @op.save
  redirect "/console/user-settings?status=success"
end

post '/console/password' do
  if params[:new] != params[:verify]
    redirect "/console/user-settings?status=verify_error"
  elsif Operator.auth(@op.id, params[:current]).nil?
    redirect "/console/user-settings?status=auth_error"
  end

  @op.encrypt_password(params[:new])
  @op.save
  redirect "/console/user-settings?status=pass_success"
end
