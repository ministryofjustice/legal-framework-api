require "swagger_helper"

RSpec.describe "proceeding_type_defaults" do
  path "/proceeding_type_defaults" do
    post("Return details of default scope and level of service for specified proceeding_type_ccms_code, delegated_functions_used, client_involvement_type") do
      description "POST a JSON payload containing a proceeding_type_ccms_code, boolean whether delegated_functions_used and client_involvement_type
                  to recieve a payload containing the same request params, and the default scope and level_of_service."

      let(:proceeding_type_defaults_query) do
        {
          proceeding_type_ccms_code: "SE013",
          delegated_functions_used: false,
          client_involvement_type: "A",
        }
      end

      tags "Proceeding types defaults"
      consumes "application/json"
      produces "application/json"
      parameter name: :proceeding_type_defaults_query,
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
        expected_response =
          {
            success: true,
            requested_params: {
              proceeding_type_ccms_code: "SE013",
              delegated_functions_used: false,
              client_involvement_type: "A",
            },
            default_level_of_service: {
              level: 1,
              name: "Family Help (Higher)",
              stage: 1,
            },
            default_scope: {
              code: "FM059",
              meaning: "FHH Children",
              description: "Limited to Family Help (Higher) and to all steps necessary to negotiate and conclude a settlement. To include the issue of proceedings and representation in those proceedings save in relation to or at a contested final hearing.",
              additional_params: [],
            },
          }.as_json
        example "application/json",
                :success,
                expected_response,
                "Successful request",
                "Return details of default scope and level of service for specified proceeding_type_ccms_code, delegated_functions_used, client_involvement_type"
        run_test! do |response|
          expect(response).to have_http_status(:success)
          expect(response.body).to eq expected_response.to_json
        end
      end

      response(400, "bad request") do
        let(:proceeding_type_defaults_query) do
          {
            proceeding_type_ccms_code: "XX123",
            delegated_functions_used: false,
            client_involvement_type: "A",
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            "application/json": {
              examples: {
                bad_request: {
                  value: JSON.parse(response.body, symbolize_names: true),
                  summary: "Unsuccessful request",
                  description: "When invalid proceeding types are submitted an error will be raised and returned to the users",
                },
              },
            },
          }
        end

        run_test! do |response|
          expect(response).to have_http_status(:bad_request)
          expect(parsed_response[:success]).to be false
          expect(parsed_response[:errors]).to match [/The property '#\/proceeding_type_ccms_code' value "XX123" did not match one of the following values: .* in schema file/]
        end
      end
    end
  end
end
