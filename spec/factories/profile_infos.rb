FactoryBot.define do
  factory :profile_info do
    username { "sample_user" }
    followers { "100" }
    following { "50" }
    stars { "10" }
    contributions { "200" }
    profile_image_url { "https://example.com/avatar.jpg" }
    organization { "Sample Org" }
    location { "Sample Location" }
    association :profile
  end
end
