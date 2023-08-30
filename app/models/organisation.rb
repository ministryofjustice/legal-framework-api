class Organisation < ApplicationRecord
  belongs_to :organisation_type

  validates :name, :ccms_code, :searchable_type, presence: true

  def api_json
    as_json(only: %i[name ccms_code searchable_type])
  end
end
