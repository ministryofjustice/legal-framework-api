require "swagger_helper"

RSpec.describe "proceeding_type_defaults", type: :request, swagger: true do
  path "/proceeding_type_defaults" do
    post("Return details of default scope and level of service for specified proceeding_type_ccms_code, delegated_functions_used, client_involvement_type") do
      description "POST a JSON payload containing a proceeding_type_ccms_code, boolean whether delegated_functions_used and client_involvement_type
                  to recieve a payload containing the same request params, and the default scope and level_of_service."

      proceeding_type_ccms_code = "SE004"
      delegated_functions_used = false
      client_involvement_type = "A"

      tags "Proceeding types defaults"
      response(200, "successful") do
        consumes "application/json"
        produces "application/json"
        parameter name: "proceedng_type_defaults_query",
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
                    },
                    required: %w[proceeding_type_ccms_code delegated_functions_used client_involvement_type],
                  }
        response(200, "success") do
          response = ProceedingTypeDefaultsService.call(proceeding_type_defaults_params: { proceeding_type_ccms_code:, delegated_functions_used:, client_involvement_type: }.to_json)

          examples "application/json" => response
          run_test!
        end
      end
    end
  end
end
