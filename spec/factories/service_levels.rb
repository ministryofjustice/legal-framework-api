FactoryBot.define do
  factory :service_level do
    sequence(:level) { |n| n }
    name { "Service Level #{level}" }
    stage { rand(0..9) }
  end
end
