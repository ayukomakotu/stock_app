FactoryBot.define do
  factory :stock1, class: Stock do
    number { 30 }
  end

  factory :stock2, class: Stock do
    number { 50 }
  end
end
