# ruby-rails-rspec-prac

サービス提供に付随する顧客管理システム．  
ただいまデプロイ作業中．完了次第リンクを記載します．

Ruby 2.7 on Rails 6.0 でサーバサイドを勉強するために作成．  
成果物から得られること

- チュートリアル以上の実践的な Rails の使い方
  - 詳細は [references/ruby-rails/rails-proc.md](https://github.com/krtsato/references/blob/master/ruby-rails/rails-proc.md) を参照
- RSpec, Capybara を用いたテストコードの書き方
  - 詳細は [references/ruby-rails/rspec-syntax.md](https://github.com/krtsato/references/blob/master/ruby-rails/rspec-syntax.md) を参照
- ワンコマンドで環境構築を完了させるスクリプト群

<br>

リポジトリ概要

- [機能](#機能)
- [環境](#環境)
- [環境構築](#環境構築)

<br>

## 機能

- ユーザ認証・認可
  - 管理者 : Administrator
  - 職員 : StaffMember
  - 顧客 : Customer
- 管理者の機能
  - 職員に対する CRUD
  - 職員のログイン・ログアウト記録の閲覧
  - ページネーション
  - 職員の強制ログアウト
- 職員の機能
  - アカウント閲覧・編集
  - N + 1 問題への対応
- 顧客の機能
  - アカウントの CRUD
  - 任意入力への対応
  - 電話番号への対応
- Rails 独自の共通化機能
  - フォームオブジェクト
  - サービスオブジェクト
  - プレゼンタ
  - ActiveSupport::Concern
- RSpec・Capybara によるテスト
  - shared_examples による共通化
  - FactoryBot の活用
  - できれば自動化したい…
- その他
  - エラーハンドリング
  - セッションタイムアウト
  - モデルの正規化・バリデーション
  - BCrypt によるパスワードのハッシュ化
  - DB インデックスによるクエリ高速化
  - 名前空間に基づいたコード管理
  - タスク は [Issue](https://github.com/krtsato/ruby-rails-rspec-prac/issues) で管理する
  - Issue 毎にブランチを切って実装完了後にプルリク・マージ

<br>

## 環境

- Docker
- Puma
- Nginx
- Ruby
- Rails
- PostgreSQL
- RSpec
- Capybara
- RuboCop
- Webpacker
- ERB
- AWS (Route53, ACM, ALB, EC2)

フロントエンドは今回の学習範囲に含めないため Rails モノリスで仕上げる．
なお，モダンなフロントエンドの構成・設計については [react-redux-ts-prac](https://github.com/krtsato/react-redux-ts-prac) および [redux-arch](https://github.com/krtsato/references/blob/master/react-redux-ts/redux-arch.md) を参照されたい．

<br>

## 環境構築

- 要件
  - init_proj 配下のシェルスクリプト
  - リポジトリに含まれない .env ファイル
  - ２種類のシェル
    - zsh : ホストマシン側
    - bash : コンテナ側
    - 普段は zsh を使うが Docker 内で Linux 標準の bash を動かしたかった

- 注意
  - アプリの性質上 macOS における /etc/hosts に追記する
    - ローカルで稼働させない場合は追記箇所を削除する
    - ルート権限を行使するため，シェルスクリプトが一時停止したときパスワードを入力する

- 実行内容
  - create-setup-files.sh
    - 各種設定ファイルを生成する
      - Docker 関連
      - RuboCop 関連
      - config/ 配下の一部ファイル
      - lib/ 配下の一部ファイル
      - Gemfile
      - Rakefile
      - .gitignore
  - create-rc-files.sh
    - コンテナのホームディレクトリに rc ファイルを生成する
      - .gemrc
      - .psqlrc
    - Dockerfile 内で実行される
  - setup.sh
    - 環境構築のメインスレッド
      - bundle install
      - rails new
      - yarn check
      - rails db:create
      - rails g rspec:install
      - rails g kaminari 関連
      - rubocop --auto-gen-config
      - 自動生成後のファイル編集
      - 最終的に start-rails-server.sh を呼び出す
  - start-rails-server.sh
    - web サーバを起動する
      - bundle check
      - pid ファイルの削除
      - rails s

```zsh
# init_proj/*.sh と .env を配置後
% ./init_proj/setup.sh

# 途中で入力する
Password: **********
```

- 構築後の確認
  - コンテナ
    - rrrp-web-cont
    - rrrp-db-cont
  - ブラウザから以下のアドレスにアクセスする
    - [http://rrrp.customer-manage.work:3000/admin](http://rrrp.customer-manage.work:3000/admin)
    - [http://rrrp.customer-manage.work:3000/](http://rrrp.customer-manage.work:3000/)
    - [http://customer-manage.work:3000/mypage](http://customer-manage.work:3000/mypage)
  - テストデータ
    - 管理者
      - Eメール : hanako@example.com
      - パスワード : password
    - 職員
      - Eメール : taro@example.com
      - パスワード : password

```zsh
# サーバを起動する
% docker-compose up -d
```
