FactoryBot.define do
    factory :sample1, class: Item do
        name  { "sample1" }
        unit  { "個" }
    end
    factory :sample2, class: Item do
        name  { "sample2" }
        unit  { "袋" }
    end
end
