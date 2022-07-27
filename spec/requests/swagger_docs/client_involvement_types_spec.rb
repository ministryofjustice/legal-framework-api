require "swagger_helper"

RSpec.describe "ClientInvolvementTypesController", type: :request, swagger: true do
  path "/client_involvement_types" do
    get("Get all client involvement types") do
      description "Returns an array of all client involvement types with summary data."

      tags "Client involvement types"

      produces "application/json"

      response(200, "successful") do
        seed_live_data
        examples "application/json" => ClientInvolvementType.order(:ordering).map { |cit| JSON.parse(cit.api_json) }
        run_test!
      end
    end
  end
end
