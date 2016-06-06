Category.seed do |s|
  s.id = 1
  s.url = 'git'
  s.name = 'Git'
  s.description = 'ソースコードのバージョン管理を行うGitの利点と使い方を紹介します'
  s.entries = '1'
end

Category.seed do |s|
  s.id = 2
  s.url = 'notice'
  s.name = 'お知らせ'
end

Category.seed do |s|
  s.id = 3
  s.url = 'mercurial'
  s.description = 'Mercurialを用いたバージョン管理の方法と利点を紹介します'
  s.name = 'Mercurial'
end
