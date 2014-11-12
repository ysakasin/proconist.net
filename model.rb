require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./proconist.db")

class Entrant < ActiveRecord::Base
  enum section: {competition: 0, themed: 1, original: 2}
  enum code: {github: 1, bitbucket: 2, other_code: 0}
  enum slide: {slideshare: 1, other_slide: 0}
  enum sns: {twitter: 1, facebook: 2, other_sns: 0}

  ENUMS = ['section', 'code', 'slide', 'sns']

  def sns_class_a
    "#{sns}-icon"
  end

  def sns_class_i
    "fa-#{sns}"
  end

  def code_class_link
    "#{code}-link"
  end

  def code_class_icon
    "#{code}-icon"
  end

  def code_class_i
    "fa-#{code}"
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
