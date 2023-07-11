FactoryBot.define do
  factory :pokemon do
    sequence(:id)
    name { Faker::Games::Pokemon.unique.name }
    type_1 { "prue_1" }
    total { Faker::Number.number(digits: 3) }
    attack { Faker::Number.number(digits: 2) }
    defense { Faker::Number.number(digits: 2) }
  end
end
