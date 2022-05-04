FactoryBot.define do
  factory :proceeding_type_service_level do
    proceeding_type
    service_level
    proceeding_default { [true, false].sample }

    trait :as_default do
      proceeding_default { true }
    end

    trait :as_non_default do
      proceeding_default { false }
    end
  end
end
