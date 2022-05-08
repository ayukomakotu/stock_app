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