FactoryBot.define do
    factory :user1, class: User do
        name  { "user1" }
        number { 1000 }
        password { "password" }
        password_confirmation { "password" }
    end
end