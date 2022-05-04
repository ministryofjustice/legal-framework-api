class ServiceLevel < ApplicationRecord
  has_many :proceeding_types, through: :proceeding_type_service_levels
end
