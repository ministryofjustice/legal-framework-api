class ClientInvolvementType < ApplicationRecord
  def api_json
    {
      ccms_code:,
      description:,
      ordering:,
    }.to_json
  end
end
