FactoryBot.define do
  factory :organisation do
    name { "Angus Council" }
    ccms_code { "280361" }
    searchable_type { "Local Authority" }
    organisation_type { association(:organisation_type, ccms_code: "LA", description: "Local authority") }
  end
end
