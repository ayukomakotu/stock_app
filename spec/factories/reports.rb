FactoryBot.define do
  factory :report do
    item { nil }
    process { "MyString" }
    process_number { 1 }
    day { "2022-05-11" }
    purpose { "MyString" }
    confirmer { "MyString" }
    integer { "MyString" }
    confirmation { "MyString" }
    boolean { "MyString" }
  end
end
