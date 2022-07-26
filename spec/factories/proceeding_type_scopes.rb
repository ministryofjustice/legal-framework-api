FactoryBot.define do
  factory :proceeding_type_scope do
    proceeding_type_ccms_code { ProceedingType.pluck(:ccms_code).sample }
    service_level { 1 }
    client_involvement_type_code { "A" }
    df_used { false }
    scope_limitation_code { ScopeLimitation.pluck(:code).sample }
    default { false }

    trait :se013_cv117 do
      proceeding_type_ccms_code { "SE013" }
      scope_limitation_code { "CV117" }
    end

    trait :se013_cv118 do
      proceeding_type_ccms_code { "SE013" }
      scope_limitation_code { "CV117" }
    end

    trait :se013_cv119 do
      proceeding_type_ccms_code { "SE013" }
      scope_limitation_code { "CV119" }
    end
  end
end
