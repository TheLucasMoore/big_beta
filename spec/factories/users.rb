require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Random.new(42) }
  end
end
