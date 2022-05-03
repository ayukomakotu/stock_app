items = [
    ["ハチクサン", 100, "L"],
    ["TMカウンター", 200, "g"],
    ["ブロワー", 20, "個"],
    ["かわい太郎", 50, "坪"]
]

items.each do |name, stock, unit|
    Item.create(name: name, stock: stock, unit: unit)
end