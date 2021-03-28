## アプリケーション名
  BookWorm 読書のムシ

## アプリケーション概要
  読書記録アプリ

## URL


## テスト用アカウント
email: 
password: 

## 利用方法
  新規登録・ログインしたユーザーのみBookWormを利用できる。
  読んだ書籍を検索ページで検索し、登録する。
  登録された書籍の要約や感想、今後のアクションプランを記録する。
  
## 目指した課題解決
  読書を通して学んだことをアウトプットし、更に実践すること。
  本を読んでも、情報量が多く頭に入らない・すぐに忘れてしまう・読んだ後具体的に何をしていいか分からない等の悩みがある。
  BookWormで読んだ本を記録・アウトプットすることで、内容の理解を深め、実践することができる。

## 用件定義
- ユーザー管理機能
- 書籍検索/登録機能
- レビュー機能


## 実装予定の機能
  コメント機能の実装

## データベース設計
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
 
### Association
- belongs_to :user
- belongs_to :book
