Operator.seed do |s|
  s.id = 1
  s.op_id = 'sakata'
  s.position = 1
  s.name = '酒田　シンジ'
  s.icon = '/img/sakata.png'
  s.school = '茨城高専'
  s.github = 'NKMR6194'
  s.twitter = 'NKMR6194'
  s.site = 'http://sinjis-view.mydns.jp'
  s.description = 'このサイトの言い出しっぺであるが、これを思いついた時にはすでに５年生であり、今後の高専プロコンには出場できない模様。しかし、「まだNAPROC枠がある！」といって参戦を虎視眈々と狙っている。'
  password_salt = BCrypt::Engine.generate_salt
  s.password_salt = password_salt
  s.password_hash = BCrypt::Engine.hash_secret('sakata', password_salt)
end
