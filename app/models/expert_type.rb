class ExpertType < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :description, presence: true

  def api_json
    as_json(only: %i[code description])
  end
end
