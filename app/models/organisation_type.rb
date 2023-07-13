class OrganisationType < ApplicationRecord
  def api_json
    {
      ccms_code:,
      description:,
    }.as_json
  end
end
