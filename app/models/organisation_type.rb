class OrganisationType < ApplicationRecord
  def api_json
    as_json(only: %i[ccms_code description])
  end
end
