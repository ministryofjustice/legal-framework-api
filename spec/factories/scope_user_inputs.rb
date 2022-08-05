FactoryBot.define do
  factory :scope_user_input do
    input_name { "MyText" }
    input_type { "MyText" }
    mandatory { false }

    trait :hearing_date do
      input_name { "hearing_date" }
      input_type { "date" }
      mandatory { true }
    end

    trait :opponent_name do
      input_name { "opponent_name" }
      input_type { "text" }
      mandatory { true }
    end
  end
end
