class Organisation < ApplicationRecord
  belongs_to :organisation_type

  validates :name, :ccms_code, :searchable_type, presence: true

  def api_json
    {
      name:,
      ccms_opponent_id: ccms_code,
      ccms_type_text: searchable_type,
      ccms_type_code: organisation_type.ccms_code,
    }.as_json
  end
end
