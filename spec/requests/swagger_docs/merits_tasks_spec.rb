require "swagger_helper"

RSpec.describe "merits_tasks", type: :request, swagger: true do
  path "/merits_tasks" do
    post("Return details of merits_tasks for specified proceeding types identified by CCMS-codes") do
      request_id = "7d47425b-800a-41ef-a917-934acc09b50d"
      proceeding_types = %w[DA001 DA003 SE014]

      tags "Merits tasks"
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
                                          items: { type: :string },
                                          example: proceeding_types,
                                          description: "Array of CCMS codes of proceeding types to  be queried" },
                    },
                    required: %w[request_id ccms_codes],
                  }
        response(200, "success") do
          seed_live_data
          response = MeritsTaskService.call(request_id, proceeding_types)

          examples "application/json" => response
          run_test!
        end
      end
    end
  end
end
