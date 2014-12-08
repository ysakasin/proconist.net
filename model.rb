require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => ENV['DB'] || "./proconist.db")

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
    operator = Opetator.find_by_id(user_id)
    if operator && operator.password_hash == BCrypt::Engine.hash_secret(password, operator.password_salt)
      operator
    else
      nil
    end
  end
end
