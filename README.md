proconist.net
=============

環境構築
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
下記コマンドでSinatraを立ち上げます。この際、開発用データベースが適用されます
```
rake dev_exec
```

ブラウザから自分自身の4567番ポートにアクセスします
```
localhost:4567
```
