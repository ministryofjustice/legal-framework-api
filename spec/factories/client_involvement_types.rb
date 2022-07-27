FactoryBot.define do
  factory :client_involvement_type do
    ccms_code { Faker::Base.resolve(%w[A D I W Z]) }
    description { Faker::Lorem.sentence(word_count: 4) }
    ordering { rand(1...5) }
  end
end
