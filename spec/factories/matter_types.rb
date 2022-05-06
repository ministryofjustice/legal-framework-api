FactoryBot.define do
  factory :matter_type do
    code { Faker::Base.regexify(/[A-Z]{2}[0-9]{3}/) }
    name { Faker::Lorem.sentence(word_count: 2) }
  end
end
