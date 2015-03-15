require 'bundler'
Bundler.require
require 'redcarpet/render_strip'

ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => ENV['DB'] || "./proconist.db")

SNS = {
  github: {name: 'GitHub', klass: 'fa-github-alt', base_url: 'https://github.com/'},
  bitbucket: {name: 'Bitbucket', klass: 'fa-bitbucket', base_url: 'https://bitbucket.org/'},
  other_repo: {name: 'リポジトリ', klass: 'fa-database', base_url: ''},
  slideshare: {name: 'SlideShare', klass: 'fa-slideshare', base_url: 'https://www.slideshare.net/'},
  other_slide: {name: '解説スライド', klass: 'fa-desktop', base_url: ''},
  twitter: {name: 'Twitter', klass: 'fa-twitter', base_url: 'https://twitter.com/'},
  facebook: {name: 'Facebook', klass: 'fa-facebook-square', base_url: 'https://www.facebook.com/'},
  site: {name: 'Webサイト', klass: 'fa-globe', base_url: ''}
}

class Entrant < ActiveRecord::Base
  enum section: {competition: 0, themed: 1, original: 2}

  def prizes
    prize.split(',')
  end

  def panel_class
    if is_registered?
      'panel-primary'
    else
      'panel-default'
    end
  end

  def panel_id
    "#{section}-#{registry_num}"
  end

  def links
    return @link unless @link.nil?
    @link = Array.new
    SNS.each do |key, elem|
      if self.send(key.to_s).present?
        @link << {title: elem[:name], href: self.send(key.to_s), tag_class: elem[:klass]}
      end
    end
    @link
  end

  def is_registered?
    links.present?
  end
end

class Contest < ActiveRecord::Base
  def href
    "/contest/#{id}"
  end
end

class Operator < ActiveRecord::Base
  self.primary_key = :op_id

  enum position: {common: 0, admin: 1}

  def encrypt_password(password)
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.auth(user_id, password)
    operator = Operator.find_by_op_id(user_id)
    if operator && operator.password_hash == BCrypt::Engine.hash_secret(password, operator.password_salt)
      operator
    else
      nil
    end
  end

  def sns
    res = Array.new
    SNS.each do |key, item|
      next if key == :other_repo || key == :other_slide
      if self.send(key.to_s).present?
        item[:href] = item[:base_url] + self.send(key.to_s)
        res << item
      end
    end
    res
  end

  def entry
    Article.where(auther: op_id)
  end
end

class History < ActiveRecord::Base
  enum label: {product: 0, entry: 1, notice: 2}

  ENUMS = ['label']

  def label_name
    {'product' => '作品', 'entry' => '特集', 'notice' => 'お知らせ'}[label]
  end

  def label_class
    {'product' => 'label-info', 'entry' => 'label-warning', 'notice' => 'label-danger'}[label]
  end
end

class Article < ActiveRecord::Base
  def body_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(body)
  end

  def description
    Redcarpet::Markdown.new(Redcarpet::Render::StripDown).render(body)[0, 90] + '...'
  end

  def auther_a
    return @auther if @auther
    @auther = Operator.find_by_op_id(auther)
  end

  def date
    created_at.strftime("%Y年%m月%d日")
  end

  def date_hyphen
    created_at.strftime('%F')
  end

  def categories
    res = []
    category.split(',').each do |id|
      res << Category.find_by_id(id)
    end
    res
  end

  def category_link
    links = []
    categories.each do |c|
      links << "<a href=\"#{c.href}\">#{c.name}</a>"
    end
    links.join(', ')
  end

  def category_name
    links = []
    categories.each do |c|
      links << c.name
    end
    links.join(', ')
  end

  def href
    "/entry/#{url}"
  end

  def Article.pagers(page)
    max = Article.all.size / 5 + 1
    if max > 1
    	(1..max).to_a.select{|item| item <= 3 || item >= max - 2 || (item <= page + 1 && item >= page - 1)}
    else
      []
    end
  end
end

class Category < ActiveRecord::Base
  def href
    "/category/#{url}"
  end

  def entry_id(page)
    entries.split(',')[(page-1)*5, 5].map{|item| item.to_i}
  end
end
