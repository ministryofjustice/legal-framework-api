class ExpertTypeMatterType < ApplicationRecord
  belongs_to :expert_type
  belongs_to :matter_type
end
