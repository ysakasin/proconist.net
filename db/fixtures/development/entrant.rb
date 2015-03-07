Entrant.seed do |s|
  s.id = 1
  s.contest = 1
  s.section = 0
  s.registry_num = 1
  s.school = '茨城高専'
  s.production = '賽巡TRIDE改〜ハスケル・ボトム・サウンド〜'
  s.github = 'https://github.com/inct-www-club/Procon2014'
  s.site = 'http://sandabu.net'
end

Entrant.seed do |s|
  s.id = 2
  s.contest = 1
  s.section = 0
  s.registry_num = 2
  s.school = '大阪府大高専'
  s.production = 'パズトラ！ —パズル・トライアル—'
  s.result = 2
  s.prize = ['文部科学大臣賞', '優勝', '情報処理学会若手奨励賞', 'First Runner-up Prize'].join(',')
end

Entrant.seed do |s|
  s.id = 3
  s.contest = 1
  s.section = 1
  s.registry_num = 1
  s.school = '課題部門高専'
  s.production = '作品タイトル'
  s.github = 'github'
  s.bitbucket = 'bit'
  s.other_repo = 'repo'
  s.slideshare = 'share'
  s.other_slide = 'slide'
  s.twitter = 'twitter'
  s.facebook = 'facebook'
  s.site = 'site'
end

Entrant.seed do |s|
  s.id = 4
  s.contest = 1
  s.section = 2
  s.registry_num = 1
  s.school = '自由部門高専'
  s.production = '作品タイトル'
  s.github = 'github'
  s.bitbucket = 'bit'
  s.other_repo = 'repo'
  s.slideshare = 'share'
  s.other_slide = 'slide'
  s.twitter = 'twitter'
  s.facebook = 'facebook'
  s.site = 'site'
end
