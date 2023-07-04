FactoryBot.define do
  factory :proceeding_type do
    ccms_code { Faker::Base.regexify(/[A-Z]{2}[0-9]{3}/) }
    meaning { Faker::Lorem.sentence(word_count: 4) }
    description { Faker::Lorem.sentence(word_count: 4) }
    name { Faker::Lorem.sentence(word_count: 2) }

    matter_type
  end
end
