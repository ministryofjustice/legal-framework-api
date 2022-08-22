class ScopeUserInput < ApplicationRecord
  validates :input_type, inclusion: { in: %w[date text], message: "%{value} is not a valid input_type" }

  def as_json
    {
      name: input_name,
      type: input_type,
      mandatory:,
    }
  end
end
