proconist.net
=============

開発環境構築
----------
bundlerを用いて開発環境の導入・管理をします  
動作環境は`Ruby 2.1.4`です

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
bundle exec rake db:migrate #データベース生成
bundle exec rake db:seed #テスト用のデータを挿入
```

下記コマンドでSinatraを立ち上げます
```
ruby app.rb
```

ブラウザから自分自身の4567番ポートにアクセスします
```
localhost:4567
```

開発環境では`sinatra-reloader`が読み込まれているので、コード変更時にもサーバーの再起動は不要です。

本番環境での注意
----------

必要なgemをインストール:  
```
bundle install　--without development
```
