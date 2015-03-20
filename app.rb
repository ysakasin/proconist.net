# coding: utf-8
require 'bundler'
Bundler.require
require './model'
require './secret'

Time.zone = "Tokyo"
ActiveRecord::Base.default_timezone = :local
if settings.development?
  set :public_folder, settings.root + '/sample'
end

helpers do
  def option_tag(label, val, selected=false)
    if selected
      "<option value=\"#{val}\" selected>#{label}</option>"
    else
      "<option value=\"#{val}\">#{label}</option>"
    end
  end

  def checkbox_tag(label, val, name, checked=false)
    if checked
      "<div class=\"checkbox\"><label><input type=\"checkbox\" value=\"#{val}\" id=\"#{name}\" name=\"#{name}\" checked>#{label}</label></div>"
    else
      "<div class=\"checkbox\"><label><input type=\"checkbox\" value=\"#{val}\" id=\"#{name}\" name=\"#{name}\">#{label}</label></div>"
    end
  end
end

get '/' do
  @contest = Contest.last

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

get '/contest' do
  erb :contest_list
end

get '/contest/:id' do |id|
  @contest = Contest.find_by_id(id)

  entrants = Entrant.where(:contest => @contest.id)
  @competition = entrants.select {|item| item.competition?}
  @themed = entrants.select {|item| item.themed?}
  @original = entrants.select {|item| item.original?}

  @history = History.order("id desc").limit(5)
  @thumbnail = History.where(label: 1).order("id desc").limit(5)

  @title = "第#{@contest.id}回#{@contest.name}作品一覧"
  @ogp_url = to()
  @ogp_description = "高専プロコン第#{@contest.id}回#{@contest.name}の作品一覧"
  erb :contest
end

get '/entry' do
  @entries = Article.order("id desc").limit(5)
  @entry_total = Article.all.size
  erb :entries
end

get '/entry/archive' do
  @categories = Category.all
  erb :archive
end

get '/entry/page/:p' do
  redirect '/entry' if params[:p] == '1'
  @entries = Article.order("id desc").limit(5).offset((params[:p].to_i - 1) * 5)
  @entry_total = Article.all.size
  erb :entries
end

get '/entry/:title' do
  @entry = Article.find_by_url(params[:title])
  @title = @entry.title
  @ogp_url = to()
  @ogp_img = to(@entry.thumbnail)
  @ogp_description = @entry.description(100, '')
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
  @title = @auther.name
  @ogp_url = to()
  @ogp_description = @auther.description
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
  if params[:history] == 'add'
    History.create(
      title: "#{@entrant.section_name} #{@entrant.school}「#{@entrant.production}」",
      label: 0,
      href: @entrant.href
    )
  end
  redirect "/console/entrant/#{params[:id]}?status=success"
end

get '/console/entry' do
  @entries = Article.all
  erb :entry, :views => 'views/console'
end

get '/console/draft/new' do
  @draft = Draft.new
  erb :draft_edit, :views => 'views/console'
end

post '/console/draft/new' do
  @draft = Draft.new
  cols = [:url, :title, :body, :auther, :thumbnail]
  cols.each do |col|
    @draft.send("#{col}=", params[col])
  end
  @draft.category = params[:category].join(',')
  @draft.save
  redirect "/console/draft/#{@draft.id}?status=success"
end

get '/console/draft/:id/publish' do
  unless @op.admin?
    raise Sinatra::NotFound
  end
  @draft = Draft.find_by_id(params[:id])
  @entry = Article.new
  cols = [:url, :title, :body, :auther, :thumbnail, :category]
  cols.each do |col|
    @entry.send("#{col}=", @draft.send("#{col}"))
  end
  @entry.save
  @draft.destroy
  @entry.categories.each do |category|
    if category.entries.blank?
      category.entries = @entry.id
      category.save
    elsif not category.entries.split(',').include?(@entry.id)
      category.entries += ",#{@entry.id}"
      category.save
    end
  end
  notice = @entry.categories.include?(Category.find_by_url('notice'))
  History.create(label: notice ? 2 : 1, title: @entry.title, href: @entry.href, img: @entry.thumbnail)
  redirect "/console/entry/#{@entry.id}?status=success"
end

get '/console/draft/:id' do
  @draft = Draft.find_by_id(params[:id])
  erb :draft_edit, :views => 'views/console'
end

post '/console/draft/:id' do
  @draft = Draft.find_by_id(params[:id])
  cols = [:url, :title, :body, :auther, :thumbnail]
  cols.each do |col|
    @draft.send("#{col}=", params[col])
  end
  @draft.category = params[:category].join(',')
  @draft.save
  redirect "/console/entry/#{params[:id]}?status=success"
end

get '/console/entry/:id' do
  @entry = Article.find_by_id(params[:id])
  erb :entry_edit, :views => 'views/console'
end

post '/console/entry/:id' do
  @entry = Article.find_by_id(params[:id])
  cols = [:url, :title, :body, :auther, :thumbnail]
  cols.each do |col|
    @entry.send("#{col}=", params[col])
  end
  @entry.category = params[:category].join(',')
  @entry.save
  params[:category].each do |c|
    category = Category.find_by_id(c.to_i)
    if category.entries.blank?
      category.entries = params[:id]
      category.save
    elsif not category.entries.split(',').include?(params[:id])
      category.entries += ",#{params[:id]}"
      category.save
    end
  end
  redirect "/console/entry/#{params[:id]}?status=success"
end

get '/console/category' do
  @categories = Category.all
  erb :category, :views => 'views/console'
end

get '/console/category/new' do
  @category = Category.new
  erb :category_edit, :views => 'views/console'
end

get '/console/category/:id' do
  @category = Category.find_by_id(params[:id])
  erb :category_edit, :views => 'views/console'
end

post '/console/category/new' do
  @category = Category.new
  cols = [:url, :name, :description, :entries]
  cols.each do |col|
    @category.send("#{col}=", params[col])
  end
  @category.save
  redirect "/console/category/#{@category.id}?status=success"
end

post '/console/category/:id' do
  @category = Category.find_by_id(params[:id])
  cols = [:url, :name, :description, :entries]
  cols.each do |col|
    @category.send("#{col}=", params[col])
  end
  @category.save
  redirect "/console/category/#{params[:id]}?status=success"
end

get '/console/user-settings' do
  erb :user_settings, :views => 'views/console'
end

post '/console/user-settings' do
  cols = [:name, :school, :github, :bitbucket, :slideshare, :twitter, :facebook, :site, :description]
  if params[:icon]
    filepath = '/img/' + @op.op_id + File.extname(params[:icon][:filename])
    File.open(File.join(settings.public_folder, filepath), "w") do |f|
      f.write(params[:icon][:tempfile].read)
    end
    @op.icon = filepath
  end
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
