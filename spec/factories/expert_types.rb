FactoryBot.define do
  factory :expert_type do
    sequence(:code) { |n| "CODE#{n}" }
    sequence(:description) { |n| "Expert Type #{n}" }
  end
end
