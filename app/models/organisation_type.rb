class OrganisationType < ApplicationRecord
  has_many :organisations

  def api_json
    as_json(only: %i[ccms_code description])
  end
end
