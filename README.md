# テーブル設計

## users　テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| name       | string | null: false |
| email      | string | null: false |
| password   | string | null: false |
| profile    | text   | null: false |
| occupation | text   | null: false |
| position   | text   | null: false |


## Association

- has_many :prototypes
- has_many :comments


## prototypes　テーブル

| Column     | Type      | Options                        |
| ---------- | ------    | ------------------------------ |
| title      | string    | null: false                    |
| concept    | text      | null: false                    |
| catch_copy | text      | null: false                    |
| user       |references | null: false, foreign_key: true |


| image      |ActiveStorageで実装する為、テーブルにカラムの追加不要|

## Association

- has_many :comments, dependent: :destroy
- belongs_to :user
- has_one_attached :image 一つの投稿に一つの画像が紐づく

親のPrototypesテーブルが削除されたら、関連づけてるComments（子モデル）も削除される。

## comments　テーブル

| Column     | Type      | Options                        |
| ---------- | ------    | ------------------------------ |
| text       | text      | null: false                    |
| user       |references | null: false, foreign_key: true |
| prototype  |references | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :prototype


注意：belongs_to メソッドの引数は『単数形』になる