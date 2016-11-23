proconist.net
=============
[![wercker status](https://app.wercker.com/status/f3646f6a1d815a2b62d879ac950d93b7/s)](https://app.wercker.com/project/bykey/f3646f6a1d815a2b62d879ac950d93b7)
[![Coverage Status](https://coveralls.io/repos/github/unasuke/proconist.net/badge.svg?branch=master)](https://coveralls.io/github/unasuke/proconist.net?branch=master)
[![Code Climate](https://codeclimate.com/github/unasuke/proconist.net/badges/gpa.svg)](https://codeclimate.com/github/unasuke/proconist.net)
[![chat on gitter](https://img.shields.io/gitter/room/gitterHQ/gitter.svg)](https://gitter.im/proconist-net/Lobby)

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

本番環境へのDeploy
----------

localで各種環境変数を設定:  
```
export PROCONISTNET_DEPLOY_USER=hogehoge
export PROCONISTNET_DEPLOY_KEY=path/to/key
export PROCONISTNET_DEPLOY_PORT=number
```

下記コマンドで本番環境へのdeployを行います:
```
bundle exec cap production deploy
```
