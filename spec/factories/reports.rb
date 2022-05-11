FactoryBot.define do
  factory :report do
    user { nil }
    item { nil }
    process { "MyString" }
    process_number { 1 }
    day { "2022-05-11" }
    purpose { "MyString" }
    confirmer { 1 }
    confirmation { false }
  end
end
