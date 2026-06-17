class MatterType < ApplicationRecord
  has_many :expert_type_matter_types, dependent: :destroy
  has_many :expert_types, through: :expert_type_matter_types
end
