class ScopeUserInput < ApplicationRecord
  validates :input_type, inclusion: { in: %w[date text], message: "%{value} is not a valid input_type" }
end
