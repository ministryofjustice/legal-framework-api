class ExpertType < ApplicationRecord
  has_many :expert_type_matter_types, dependent: :destroy
  has_many :matter_types, through: :expert_type_matter_types

  validates :code, presence: true, uniqueness: true
  validates :description, presence: true

  def self.for_matter_type(matter_type_code)
    joins(:matter_types).where(matter_types: { code: matter_type_code })
  end

  def api_json
    as_json(only: %i[code description])
  end
end
