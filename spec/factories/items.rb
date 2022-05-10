FactoryBot.define do
    factory :item1, class: Item do
        name  { "item1" }
        unit  { "個" }
    end
    factory :item2, class: Item do
        name  { "item2" }
        unit  { "袋" }
    end
end
