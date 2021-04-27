# BookWorm 〜本のムシ〜
本は読んで終わりではなく、行動に移してこそ意味があると考えています。<br>
BookWormで読んだ本を記録・アウトプットすることで、読書の価値を底上げします。


<h4>1. 読書を記録できるアプリケーションです。</h4>
<img width="1500" alt="スクリーンショット 2021-04-14 15 45 01" src="https://user-images.githubusercontent.com/77310785/114666057-c1cb7d00-9d38-11eb-984e-0ca5d1dc7f3c.png">
<br>

<h4>2. タイトルで書籍を検索し、登録することができます。</4>
<br>
<br>
<img width="1500" alt="スクリーンショット 2021-04-14 16 36 20" src="https://user-images.githubusercontent.com/77310785/114672188-d0696280-9d3f-11eb-8cb7-ccf3ccdbef46.png">
<br>
<br>

<h4>
  3. 要約・感想・その後のアクションプランを言語化し記録することで、より記憶に定着させることができます。<br>
</h4>
<img width="1500" alt="スクリーンショット 2021-04-27 18 23 47" src="https://user-images.githubusercontent.com/77310785/116220485-ae340380-a787-11eb-96ea-9f9181b5dc01.png">


# URL
https://hon-no-musi.herokuapp.com/

Basic認証
- ユーザー : honnomusi
- パスワード: 0220

ゲスト用アカウント
- Email: guest@sample.com  
- Pass : 123456abc

# 使用言語・使用技術など
- Ruby 2.6.5
- Ruby on Rails 6.0.0
- MySQL
- Heroku
- RSpec
- Github
- 楽天ブックス書籍検索API

# 機能一覧
- ユーザー登録、ログイン機能(devise)
- 書籍登録機能
  - 書籍検索(楽天ブックス書籍API)
- レビュー機能

# テスト
- RSpec
  - 単体テスト(model)
  - 結合テスト(system)

# データベース設計
## users テーブル
| Column             | Type        | Options                   |
| ------------------ | ----------- | ------------------------- |
| nickname           | string      | null: false               |
| email              | string      | null: false, unique: true |
| encrypted_password | string      | null: false               |

### Association
- has_many :books
- has_many :reviews


## books テーブル
| Column     | Type        | Options                        |
| ---------- | ----------- | ------------------------------ |
| isbn       | bigint      | primary_key: true, null: false |
| title      | string      | null: false                    |
| author     | string      | null: false                    |
| caption    | text        | null: false                    |
| image_url  | string      | null: false                    |
| url        | string      | null: false                    |
| user       | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :review


## reviews テーブル
| Column      | Type        | Options                        |
| ----------- | ----------- | ------------------------------ |
| summary     | text        |                                |
| impressions | text        |                                |
| plan        | text        |                                |
| book        | references  | null: false, foreign_key: true |
| user        | references  | null: false, foreign_key: true |
 
### Association
- belongs_to :user
- belongs_to :book
