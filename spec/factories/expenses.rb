FactoryBot.define do
  factory :expense do
    date { "2024-01-03" }
    name { "MyString" }
    description { "MyText" }
    amount { 1.5 }
  end
end
