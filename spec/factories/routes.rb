require 'faker'

FactoryBot.define do
  factory :route do
    name { Faker::Music::Phish.song }
  end
end
