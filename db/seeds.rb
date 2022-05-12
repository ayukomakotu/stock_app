items = [
    ["ハチクサン", 100, "L"],
    ["TMカウンター", 200, "g"],
    ["ブロワー", 50, "個"],
    ["かわい太郎", 40, "坪"]
]

items.each do |name, stock, unit|
    item = Item.create(name: name, unit: unit)
    Stock.create(number: stock, item: item)
end

# ユーザーをまとめて生成する
10.times do |n|
  User.create!(name: Faker::Name.name, number: n)
end

user = User.create!(name: "山根", number: 0202)

(1..3).each do |n|
    Report.create(user_id: User.find(n), item_id: Item.find(n), process: "出庫", day: Date.today,
                purpose: "コダマ邸使用のため", confirmer: nil, confirmation: false)
    Report.create(user_id: User.find(n), item_id: Item.find(n), process: "出庫", day: Date.today,
                purpose: nil, confirmer: user.id, confirmation: true)
    Report.create(user_id: User.find(n), item_id: Item.find(n), process: "入庫", day: Date.today,
                purpose: "コダマ邸使用のため", confirmer: nil, confirmation: false)
    Report.create(user_id: User.find(n), item_id: Item.find(n), process: "入庫", day: Date.today,
                purpose: nil, confirmer: user.id, confirmation: true)
end
