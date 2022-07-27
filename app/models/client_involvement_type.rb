class ClientInvolvementType < ApplicationRecord
  def api_json
    {
      ccms_code:,
      description:,
    }.to_json
  end
end
