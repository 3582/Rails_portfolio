# 概要
CRUD機能を持ったAPI
- 作成したタスクのCRUD機能を持つ
    - タスクの積み上げ回数のランキングを返却
- ユーザ認証機能
投稿機能API定義書https://3582.github.io/Rails_portfolio/posts.html
認証機能API定義書https://3582.github.io/Rails_portfolio/auth.html

# 使用技術
- Ruby 2.5.8
- Ruby on Rails(API) 5.2.2
- MySQL 5.7
- Nginx
- Puma
- Unicorn
- AWS
    - VPC
    - EC2
- Docker/Docker-compose
- Rspec

# AWS構成図
![image](https://user-images.githubusercontent.com/43181466/109411011-3b561880-79e2-11eb-8c96-b0d4dcaff877.png)
# ER図
![image](https://user-images.githubusercontent.com/43181466/109412012-0600f900-79e9-11eb-83fc-eb285dc8f622.png)

# 機能一覧
- ユーザー登録、ログイン機能(devise)
- 投稿機能
- ランキング機能

# テスト
  - 単体テスト(model)
  - 機能テスト(request)
