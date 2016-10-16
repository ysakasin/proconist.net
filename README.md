proconist.net
=============

開発環境構築
----------
bundlerを用いて開発環境の導入・管理をします  
動作環境は`Ruby 2.3.1`です

bundlerをインストール:  
```
gem install bundler
```

必要なgemをインストール:  
```
bundle install
```

実行と、表示の確認方法
----------
テスト用データベースを用意します
```
bundle exec rails db:migrate #データベース生成
```

下記コマンドでrailsを立ち上げます
```
bundle exec rails server
```

ブラウザから自分自身の3000番ポートにアクセスします
```
localhost:3000
```

本番環境での注意
----------

必要なgemをインストール:  
```
bundle install --without development
```
