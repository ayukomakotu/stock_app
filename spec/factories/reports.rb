FactoryBot.define do
  factory :report1, class: Report do
    process { "出庫" }
    process_number { 3 }
    day { "2022-05-11" }
    purpose { "こだま邸白蟻駆除" }
    confirmer_id { nil }
    confirmation { false }
  end
  factory :report2, class: Report do
    process { "入庫" }
    process_number { 3 }
    day { "2022-05-11" }
    purpose { nil }
    confirmer_id { 1 }
    confirmation { true }
  end
  factory :sample, class: Report do
    process { "出庫" }
    process_number { 3 }
    day { "2022-05-13" }
    purpose { "sample使用" }
    confirmer_id { 1 } 
    confirmation { true } 
  end
end
