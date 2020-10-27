# 簡易ブログアプリ
オススメのご飯屋さんのメニューを紹介する簡易ブログアプリです。

### 実装されてる機能の一覧

- deviceを使ったユーザー管理とログイン・ログアウト機能
- ブログ機能
- コメント機能
- お気に入り機能
- 検索機能
- 画像アップロード機能
- フォロー機能
- カテゴリー(タグ)機能
- 多言語化対応
- ページネーション
- Rspecを使ったテスト
- CircleCIによる自動テスト

## どのように利用するのか？
ポートフォリオの雛形としても利用してください。

実装されてる機能毎にプルリクを作り詳細な解説を加えています。

また、Dockerを使用しているので、ローカルにpullして開発環境を立ち上げて自分でデバッグしながら動作確認もできます。

アプリの使い方ですが、ユーザーの登録と認証、ブログを投稿したりコメントやいいねをするシンプルなアプリなので、直感的に利用できるかと思います。機能的な疑問点や質問はslackで私にお伝えください。

### プルリクエスト
実装されてる機能の一覧と対応してるプルリクエストのリンクです。

- [deviceを使ったユーザー管理とログイン・ログアウト機能](https://github.com/belion-freee/sns_with_rails6/pull/1)
  - deviceを導入してのユーザーのセッション管理を実装しています
- [ブログ機能](https://github.com/belion-freee/sns_with_rails6/pull/1)
  - Rails6の機能であるActionTextを利用してのブログのCRUD機能を実装しています。
- [コメント機能](https://github.com/belion-freee/sns_with_rails6/pull/3)
  - Ajaxを利用してのコメントの追加、削除機能を実装しています。
- [お気に入り機能](https://github.com/belion-freee/sns_with_rails6/pull/6)
  - Ajaxを利用してのお気に入りの追加、削除機能を実装しています。
- [検索機能](https://github.com/belion-freee/sns_with_rails6/pull/8)
  - 検索機能を実装しています。Ransackではなくて自前で実装してます。
- [画像アップロード機能](https://github.com/belion-freee/sns_with_rails6/pull/9)
  - carrierwaveを使って画像アップロード機能を実装してます。
- [フォロー機能](https://github.com/belion-freee/sns_with_rails6/pull/14)
  - Ajaxを利用してのフォロー機能を実装してます。
- [カテゴリー(タグ)機能](https://github.com/belion-freee/sns_with_rails6/pull/15)
  - ブログにカテゴリー機能を実装しています。
- [多言語化対応](https://github.com/belion-freee/sns_with_rails6/pull/18)
  - I18nを使っての多言語化対応を実装しています。要するに日本語化対応です。
- [ページネーション](https://github.com/belion-freee/sns_with_rails6/pull/10)
  - kaminariを使ってページネーション機能を実装してます。
- [Rspecを使ったテスト](https://github.com/belion-freee/sns_with_rails6/pull/11)
  - Rspecを使って単体テストと統合テストを実装しています。
- [CircleCIによる自動テスト](https://github.com/belion-freee/sns_with_rails6/pull/12)
  - 自動テストの設定とREADMEへのバッジ追加を実装してます。

#### 参考になりそうなプルリクエスト
以下は見なくてもいいけど参考になりそうなプルリクエストです。

- [初期データ投入](https://github.com/belion-freee/sns_with_rails6/pull/4)
  - seedsファイルを使って初期データの投入をしています。
- [デザインの修正](https://github.com/belion-freee/sns_with_rails6/pull/5)
  - Bootstrap4の機能をなるべく使うようにしてます。css書かなくてもわりと調整できます。
- [Ransack導入](https://github.com/belion-freee/sns_with_rails6/pull/16)
  - Ransackを導入しています。

### ローカルで動かす
GitHubからpullしてきたらプロジェクトフォルダに移動して、`./qs init --webpack`してください。

```
$ git clone https://github.com/belion-freee/sample_restraunt_blog.git <Project name>
$ cd <Project name>
$ ./qs init --webpack
```

`http://localhost:3000`にアクセスするとアプリが利用可能です。

以降の開発では `./qs server` でアプリを起動すると、webpack-dev-serverによるホットリロードが実行されたり、[byebug](https://github.com/deivid-rodriguez/byebug)が利用できるので、開発効率が上がりオススメです。


seedで初期アカウントを登録してるので、すぐに動作確認できます。
```
# You can use those accounts

name: "hoge"
email: "hoge@sample.com"
password: "Password"

name: "foo"
email: "foo@sample.com"
password: "Password"
```

### 自分のリポジトリへの反映
自分のGitHubリポジトリを作成した上で、以下のコマンドをプロジェクトフォルダで実行してください。

```
$ rm -rf .git
$ git init
$ git add .
$ git commit -a -m "Initial Commit"
$ git remote add origin <自分のGitHubのURL>
$ git push -u origin master
```
