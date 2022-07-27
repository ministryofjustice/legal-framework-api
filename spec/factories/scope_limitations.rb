FactoryBot.define do
  factory :scope_limitation do
    code { Faker::Base.regexify(/[A-Z]{2}[0-9]{3}/) }
    meaning { Faker::Lorem.sentence(word_count: 4) }
    description { Faker::Lorem.sentence(word_count: 4) }
    substantive { [true, false].sample }
    delegated_functions { [true, false].sample }

    trait :cv117 do
      code { "CV117" }
      meaning { "Interim order inc. return date" }
      description { "Limited to all steps necessary to apply for an interim order; where application is made without notice to include representation on the return date." }
      substantive { true }
      delegated_functions { true }
    end
  end
end
