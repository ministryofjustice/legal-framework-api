class ClientInvolvementType < ApplicationRecord
  VALID_CLIENT_INVOLVEMENT_TYPES = %w[A D I W Z].freeze

  validates :ccms_code, inclusion: { in: VALID_CLIENT_INVOLVEMENT_TYPES, message: "%{value} is not a valid client_involvement_type" }

  def api_json
    as_json(only: %i[ccms_code description])
  end
end
