require "swagger_helper"

RSpec.describe "threshold_waivers", type: :request, swagger: true do
  path "/proceeding_types/threshold_waivers" do
    post("Return details of threshold waivers for specified proceeding types identified by CCMS-codes") do
      request_id = "ff9679d7-ca3e-40b8-a47e-5006895d9026"
      ccms_codes = %w[DA001 DA003 SE014]

      tags "Threshold waivers"
      response(200, "successful") do
        consumes "application/json"
        produces "application/json"
        parameter name: "threshold_waiver_query",
                  in: :body,
                  schema: {
                    type: :object,
                    properties: {
                      request_id: { type: :string,
                                    example: request_id,
                                    description: "Client generated request id that will be echoed back in the response" },
                      proceeding_types: { type: :array,
                                          items: { type: :string, description: "CCMS-codes of proceedings to be queried" },
                                          example: ccms_codes },
                    },
                    required: %w[request_id ccms_codes],
                  }
        response(200, "success") do
          seed_live_data
          response = ThresholdWaiverService.call(request_id, ccms_codes)

          examples "application/json" => response
          run_test!
        end
      end
    end
  end
end
