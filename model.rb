require 'bundler'
Bundler.require

ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => ENV['DB'] || "./proconist.db")

SNS = [
  {key: :github, name: 'GitHub', klass: 'fa-github-alt', base_url: 'https://github.com/'},
  {key: :bitbucket, name: 'Bitbucket', klass: 'fa-bitbucket', base_url: 'https://bitbucket.org/'},
  {key: :slideshare, name: 'SkideShare', klass: 'fa-slideshare', base_url: 'https://www.slideshare.net/'},
  {key: :twitter, name: 'Twitter', klass: 'fa-twitter', base_url: 'https://twitter.com/'},
  {key: :facebook, name: 'Facebook', klass: 'fa-facebook-square', base_url: 'https://www.facebook.com/'},
  {key: :site_url, name: 'Webサイト', klass: 'fa-globe', base_url: ''}
]

class Entrant < ActiveRecord::Base
  enum section: {competition: 0, themed: 1, original: 2}
  enum code: {github: 1, bitbucket: 2, other_code: 0}
  enum slide: {slideshare: 1, other_slide: 0}
  enum sns: {twitter: 1, facebook: 2, other_sns: 0}

  ENUMS = ['section', 'code', 'slide', 'sns']

  def prizes
    prize.split(',')
  end

  def sns_class_i
    if sns == 'facebook'
      'fa-facebook-square'
    else
      "fa-#{sns}"
    end
  end

  def slide_class_i
    "fa-#{slide}"
  end

  def code_class_i
    if code == 'github'
      'fa-github-alt'
    else
      "fa-#{code}"
    end
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
    _links = []
    _links << {title: code, href: code_url, tag_class: code_class_i}
    _links << {title: slide, href: slide_url, tag_class: slide_class_i}
    _links << {title: '解説サイト', href: site_url, tag_class: 'fa-globe'}
    _links << {title: sns, href: sns_url, tag_class: sns_class_i}
    return _links
  end

  def is_registered?
    code_url.present? || slide_url.present? || site_url.present? || sns_url.present?
  end
end

class Contest < ActiveRecord::Base
end

class Operator < ActiveRecord::Base
  attr_readonly :password_hash, :password_salt

  enum position: {common: 0, admin: 1}

  def encrypt_password(password)
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.auth(user_id, password)
    operator = Operator.find_by_id(user_id)
    if operator && operator.password_hash == BCrypt::Engine.hash_secret(password, operator.password_salt)
      operator
    else
      nil
    end
  end

  def sns
    res = Array.new
    SNS.each do |item|
      item[:href] = item[:base_url] + self.send(item[:key].to_s)
      res << item if item[:href].present?
    end
    res
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

  def auther_a
    return @auther if @auther
    @auther = Operator.find_by_id(auther)
  end

  def date
    created_at.strftime("%Y年%m月%d日")
  end
end
