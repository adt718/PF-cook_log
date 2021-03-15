# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do

  99.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@example.com"
  password = "password"
  user = User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
  end
end
ActiveRecord::Base.transaction do

  10.times do |n|
  Dish.create!(name: Faker::Food.dish,
               description: "冬に食べたくなる、身体が温まる料理です",
               portion: 1.5,
               tips: "ピリッと辛めに味付けするのがオススメ",
               reference: "https://cookpad.com/recipe/2798655",
               required_time: 30,
               popularity: 5,
               cook_memo: "初めて作った割にはうまくできた！",
               user_id: User.first.id)
  dish = Dish.first
  Log.create!(dish_id: dish.id,
              content: dish.cook_memo)
  end
end

ActiveRecord::Base.transaction do
  # リレーションシップ
  users = User.all
  user  = users.first
  following = users[2..50]
  followers = users[3..40]
  following.each { |followed| user.follow(followed) }
  followers.each { |follower| follower.follow(user) }
end

ActiveRecord::Base.transaction do
  # ユーザー
  User.create!(
  [
    {
      name:  "山田 太郎",
      email: "sample@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      admin: true},

    {
      name:  "山田 良子",
      email: "yamada@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      admin: true,
    },
    {
      name:  "鈴木 恵子",
      email: "suzuki@example.com",
      password:              "password",
      password_confirmation: "password",
    },
    {
      name:  "採用 太郎",
      email: "recruit@example.com",
      password:              "password",
      password_confirmation: "password",
      admin: true,
    },
  ]
  )
end

  # フォロー関係
  user1 = User.first
  user2 = User.second
  user3 = User.third
  user3.follow(user1)
  user3.follow(user2)

 # 料理
  portion = 2
  description1 = "冬に食べたくなる、身体が温まる料理です。"
  description2 = "栄養バランスが良いオススメ料理です。"
  description3 = "スピード重視の簡単料理！"
  tips1 = "野菜を事前に煮込んで柔らかくしておくと良いです！"
  tips2 = "隠し味の胡椒がポイント！"
  tips3 = "少し焦げ目をつけると美味しいです！"
  cook_memo1 = "初めて作った割にはうまくできた！"
  cook_memo2 = "味が薄めだったので、次はもう少し濃い味付けにしよう。"
  cook_memo3 = "大好評だったので、また作ろう！"

ActiveRecord::Base.transaction do

  ## 3ユーザー、それぞれ5料理ずつ作成
  Dish.create!(
  [
    {
      name: "肉じゃが",
      user_id: User.first.id,
      description: description1,
      portion: portion,
      tips: tips1,
      reference: "https://cookpad.com/recipe/5905307",
      required_time: 30,
      popularity: 3,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/dish_image/dish1.jpg"),
      ingredients_attributes: [
                                { name: "豚ロース肉", quantity: "300g" },
                                { name: "じゃがいも", quantity: "2個" },
                                { name: "にんじん", quantity: "1本" },
                                { name: "玉ねぎ", quantity: "1個" },
                                { name: "しょうゆ", quantity: "大さじ2" },
                                { name: "みりん", quantity: "大さじ2" },
                                { name: "酒", quantity: "大さじ2" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "ソーセージと卵の炒め物",
      user_id: User.second.id,
      description: description2,
      portion: portion,
      tips: tips2,
      reference: "https://cookpad.com/recipe/5890533",
      required_time: 20,
      popularity: 4,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/dish_image/dish2.jpg"),
      ingredients_attributes: [
                                { name: "ソーセージ", quantity: "4本" },
                                { name: "卵", quantity: "2個" },
                                { name: "胡椒", quantity: "少々" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "かに玉",
      user_id: User.third.id,
      description: description3,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5826415",
      required_time: 15,
      popularity: 4,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/dish_image/dish3.jpg"),
      ingredients_attributes: [
                                { name: "卵", quantity: "6個" },
                                { name: "かに玉の素", quantity: "1袋" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "豚こまの生姜焼き",
      user_id: User.first.id,
      description: description2,
      portion: portion,
      tips: tips2,
      reference: "https://cookpad.com/recipe/5892456",
      required_time: 20,
      popularity: 3,
      cook_memo: cook_memo2,
      picture: open("#{Rails.root}/public/dish_image/dish4.jpg"),
      ingredients_attributes: [
                                { name: "豚こま切れ肉", quantity: "100g" },
                                { name: "玉ねぎ", quantity: "1個" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "鶏肉のチーズ照り焼き",
      user_id: User.second.id,
      description: description3,
      portion: portion,
      tips: tips2,
      reference: "https://cookpad.com/recipe/5878179",
      required_time: 40,
      popularity: 5,
      cook_memo: cook_memo3,
      picture: open("#{Rails.root}/public/dish_image/dish5.jpg"),
      ingredients_attributes: [
                                { name: "鶏肉", quantity: "100g" },
                                { name: "チーズ", quantity: "3枚" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "タンドリーチキン",
      user_id: User.third.id,
      description: description2,
      portion: portion,
      tips: tips2,
      reference: "https://cookpad.com/recipe/5909869",
      required_time: 30,
      popularity: 3,
      cook_memo: cook_memo2,
      picture: open("#{Rails.root}/public/dish_image/dish6.jpg"),
      ingredients_attributes: [
                                { name: "鶏胸肉", quantity: "300g" },
                                { name: "塩", quantity: "少々" },
                                { name: "胡椒", quantity: "少々" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "鶏肉の味噌照り焼き",
      user_id: User.first.id,
      description: description3,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5899721",
      required_time: 20,
      popularity: 5,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/dish_image/dish7.jpg"),
      ingredients_attributes: [
                                { name: "鶏肉", quantity: "250g" },
                                { name: "味噌", quantity: "大さじ1" },
                                { name: "玉ねぎ", quantity: "0.5個" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "豚しゃぶレタス",
      user_id: User.second.id,
      description: description2,
      portion: portion,
      tips: tips2,
      reference: "https://cookpad.com/recipe/5849961",
      required_time: 30,
      popularity: 4,
      cook_memo: cook_memo2,
      picture: open("#{Rails.root}/public/dish_image/dish8.jpg"),
      ingredients_attributes: [
                                { name: "レタス", quantity: "1/4個" },
                                { name: "しゃぶしゃぶ用豚肉", quantity: "100g" },
                                { name: "三つ葉", quantity: "2束" },
                                { name: "胡椒", quantity: "1振り" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "チーズオムレツ",
      user_id: User.third.id,
      description: description3,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5355585",
      required_time: 20,
      popularity: 5,
      cook_memo: cook_memo3,
      picture: open("#{Rails.root}/public/dish_image/dish9.jpg"),
      ingredients_attributes: [
                                { name: "卵", quantity: "2個" },
                                { name: "とろけるチーズ", quantity: "大さじ2" },
                                { name: "オリーブオイル", quantity: "小さじ2" },
                                { name: "胡椒", quantity: "少々" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                 { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "スペインオムレツ",
      user_id: User.first.id,
      description: description3,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5712829",
      required_time: 20,
      popularity: 5,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/dish_image/dish10.jpg"),
      ingredients_attributes: [
                                { name: "卵", quantity: "4個" },
                                { name: "じゃがいも", quantity: "1個" },
                                { name: "玉ねぎ", quantity: "0.5個" },
                                { name: "胡椒", quantity: "少々" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "ぶりの照り焼き",
      user_id: User.second.id,
      description: description1,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5628386",
      required_time: 40,
      popularity: 3,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/dish_image/dish11.jpg"),
      ingredients_attributes: [
                                { name: "ブリ", quantity: "6枚" },
                                { name: "しょうゆ", quantity: "40ml" },
                                { name: "みりん", quantity: "100ml" },
                                { name: "酒", quantity: "80ml" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "カレーライス",
      user_id: User.third.id,
      description: description1,
      portion: portion,
      tips: tips1,
      reference: "https://cookpad.com/recipe/4779250",
      required_time: 40,
      popularity: 4,
      cook_memo: cook_memo2,
      picture: open("#{Rails.root}/public/dish_image/dish12.jpg"),
      ingredients_attributes: [
                                { name: "鶏肉", quantity: "500g" },
                                { name: "玉ねぎ", quantity: "3個" },
                                { name: "にんじん", quantity: "3本" },
                                { name: "じゃがいも", quantity: "2個" },
                                { name: "なす", quantity: "1個" },
                                { name: "カレールー", quantity: "0.5箱" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "麻婆豆腐",
      user_id: User.first.id,
      description: description1,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5908616",
      required_time: 20,
      popularity: 5,
      cook_memo: cook_memo3,
      picture: open("#{Rails.root}/public/dish_image/dish13.jpg"),
      ingredients_attributes: [
                                { name: "牛ひき肉", quantity: "50g" },
                                { name: "絹豆腐", quantity: "2丁" },
                                { name: "麻婆豆腐の素", quantity: "1袋" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "肉豆腐",
      user_id: User.second.id,
      description: description2,
      portion: portion,
      tips: tips1,
      reference: "https://cookpad.com/recipe/5866590",
      required_time: 40,
      popularity: 4,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/dish_image/dish14.jpg"),
      ingredients_attributes: [
                                { name: "大葉", quantity: "4枚" },
                                { name: "薄切り肉", quantity: "100g" },
                                { name: "豆腐", quantity: "1/2丁" },
                                { name: "きのこ", quantity: "60g" },
                                { name: "しらたき", quantity: "50g" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "豚汁",
      user_id: User.third.id,
      description: description1,
      portion: portion,
      tips: tips1,
      reference: "https://cookpad.com/recipe/5789404",
      required_time: 50,
      popularity: 5,
      cook_memo: cook_memo3,
      picture: open("#{Rails.root}/public/dish_image/dish15.jpg"),
      ingredients_attributes: [
                                { name: "豚肉", quantity: "150g" },
                                { name: "ごぼう", quantity: "1/2本" },
                                { name: "にんじん", quantity: "1本" },
                                { name: "大根", quantity: "1/8本" },
                                { name: "こんにゃく", quantity: "50g" },
                                { name: "長ネギ", quantity: "1/2本" },
                                { name: "ごま油", quantity: "大さじ1" },
                                { name: "味噌", quantity: "大さじ4" },
                                { name: "酒", quantity: "大さじ1" },
                                { name: "七味唐辛子", quantity: "お好み" }
                              ],
    }
  ]
  )
end


  dish3 = Dish.find(3)
  dish6 = Dish.find(6)
  dish12 = Dish.find(12)
  dish13 = Dish.find(13)
  dish14 = Dish.find(14)
  dish15 = Dish.find(15)

  # お気に入り登録
  user3.favorite(dish13)
  user3.favorite(dish14)
  user1.favorite(dish15)
  user2.favorite(dish12)

  # コメント
  dish15.comments.create(user_id: user1.id, content: "美味しそう！私も食べてみたい！")
  dish12.comments.create(user_id: user2.id, content: "また作ってー！")

  # 通知
  user3.notifications.create(user_id: user3.id, dish_id: dish15.id,
                           from_user_id: user1.id, variety: 1)
  user3.notifications.create(user_id: user3.id, dish_id: dish15.id,
                           from_user_id: user1.id, variety: 2, content: "美味しそう！私も食べてみたい！")
  user3.notifications.create(user_id: user3.id, dish_id: dish12.id,
                           from_user_id: user2.id, variety: 1)
  user3.notifications.create(user_id: user3.id, dish_id: dish12.id,
                           from_user_id: user2.id, variety: 2, content: "また作ってー！")
  # リスト
  user3.list(dish3)
  user1.list(dish15)
  user3.list(dish6)
  user2.list(dish12)

  # ログ
  Dish.all.each do |dish|
  Log.create!(dish_id: dish.id,
              content: dish.cook_memo)
  end
