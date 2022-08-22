class ServiceLevel < ApplicationRecord
  has_many :proceeding_type_service_levels, dependent: :destroy
  has_many :proceeding_types, through: :proceeding_type_service_levels

  def as_json
    {
      level:,
      name:,
      stage:,
    }
  end
end
