class Country < ApplicationRecord
  validates :code, :description, presence: true

  def api_json
    {
      code:,
      description:,
    }.as_json
  end
end
