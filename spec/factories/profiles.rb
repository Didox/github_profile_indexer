FactoryBot.define do
  factory :profile do
    name { Faker::Name.name }
    github_url { Faker::Internet.url }
  end
end
