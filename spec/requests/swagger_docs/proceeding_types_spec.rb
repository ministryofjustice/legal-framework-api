require "swagger_helper"

RSpec.describe "proceeding_types", type: :request, swagger: true do
  path "/proceeding_types/{ccms_code}" do
    parameter name: "ccms_code",
              in: :path,
              type: :string,
              example: "SE013",
              description: "CCMS code, e.g. DA001 or SE013"

    get("Show details for a single proceeding type") do
      tags "Proceeding types"

      produces "application/json"

      response(200, "successful") do
        seed_live_data
        examples "application/json" => ProceedingTypeService.call("SE013")
        run_test!
      end

      response(400, "Bad request") do
        examples "application/json" => ProceedingTypeService.call("XX999")
        run_test!
      end
    end
  end
end
