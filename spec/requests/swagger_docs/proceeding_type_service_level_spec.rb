require "swagger_helper"

RSpec.describe "proceeding_type_level_of_service", type: :request, swagger: true do
  path "/proceeding_type_level_of_service" do
    post("Return details of level_of_service and scope_limitations for specified proceeding_type_ccms_code, delegated_functions_used, client_involvement_type and level_of_service_code") do
      description "POST a JSON payload containing a proceeding_type_ccms_code, boolean whether delegated_functions_used, client_involvement_type and level_of_service_code
                  to recieve a payload containing the same request params, and level_of_service and associated scope_limitations."

      proceeding_type_ccms_code = "SE004"
      delegated_functions_used = false
      client_involvement_type = "A"
      level_of_service_code = 1

      tags "Proceeding type service level"
      response(200, "successful") do
        consumes "application/json"
        produces "application/json"
        parameter name: "proceeding_type_service_level_query",
                  in: :body,
                  schema: {
                    type: :object,
                    properties: {
                      proceeding_type_ccms_code: { type: :string,
                                                   description: "A code uniquely identifying the proceeding_type" },
                      delegated_functions_used: { type: :boolean,
                                                  description: "A boolean indicating whether delegated functions were used" },
                      client_involvement_type: { type: :string,
                                                 description: "A code uniquely identifying the client_involvement_type" },
                      level_of_service_code: { type: :integer,
                                               description: "A code uniquely identifying the service_level" },
                    },
                    required: %w[proceeding_type_ccms_code delegated_functions_used client_involvement_type service_level],
                  }
        response(200, "success") do
          response = ProceedingTypeServiceLevelService.call(proceeding_type_level_of_service_params: { proceeding_type_ccms_code:, delegated_functions_used:, client_involvement_type:, level_of_service_code: }.to_json)

          examples "application/json" => response
          run_test!
        end
      end
    end
  end
end
