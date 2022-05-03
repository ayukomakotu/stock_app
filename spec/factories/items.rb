FactoryBot.define do
    factory :sample1, class: Item do
        name  { "sample1" }
        stock { 10 }
        unit  { "個" }
    end
    factory :sample2, class: Item do
        name  { "sample2" }
        stock { 20 }
        unit  { "袋" }
    end
end
