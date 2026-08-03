class ExpertTypeMatterType < ApplicationRecord
  belongs_to :expert_type
  belongs_to :matter_type

  validates :expert_type_id, uniqueness: { scope: :matter_type_id }
end
