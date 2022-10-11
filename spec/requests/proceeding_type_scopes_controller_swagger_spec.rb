require "swagger_helper"

RSpec.describe "proceeding_type_scopes", type: :request do
  path "/proceeding_type_scopes" do
    post("Return details of level_of_service and scope_limitations for specified proceeding_type_ccms_code, delegated_functions_used, client_involvement_type and level_of_service_code") do
      description "POST a JSON payload containing a proceeding_type_ccms_code, boolean whether delegated_functions_used, client_involvement_type and level_of_service_code
                  to recieve a payload containing the same request params, and level_of_service and associated scope_limitations."

      let(:proceeding_type_scopes_query) do
        {
          proceeding_type_ccms_code: "SE013",
          delegated_functions_used: false,
          client_involvement_type: "A",
          level_of_service_code: 1,
        }
      end

      tags "Proceeding type service level"
      response(200, "successful") do
        consumes "application/json"
        produces "application/json"
        parameter name: :proceeding_type_scopes_query,
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
          expected_response =
            {
              success: true,
              requested_params: {
                proceeding_type_ccms_code: "SE013",
                delegated_functions_used: false,
                client_involvement_type: "A",
                level_of_service_code: 1,
              },
              level_of_service: {
                level: 1,
                name: "Family Help (Higher)",
                stage: 1,
                scope_limitations: [
                  {
                    code: "FM007",
                    meaning: "Blood Tests or DNA Tests",
                    description: "Limited to all steps up to and including the obtaining of blood tests or DNA tests and thereafter a solicitor's report.",
                    additional_params: [],
                  },
                  {
                    code: "FM004",
                    meaning: "CAFCASS report",
                    description: "Limited to all steps up to and including the Children and Family Reporter's Report and thereafter a solicitor's report.",
                    additional_params: [],
                  },
                  {
                    code: "CV079",
                    meaning: "Counsel's Opinion",
                    description: "Limited to obtaining external Counsel's Opinion or the opinion of an external solicitor with higher court advocacy rights on the information already available.",
                    additional_params: [],
                  },
                  {
                    code: "FM019",
                    meaning: "Exchange of Evidence",
                    description: "Limited to all steps up to and including the exchange of evidence (including any welfare officer's/guardian ad litem's report) and directions appointments but not including a final contested hearing and thereafter to a solicitors report (or if so advised a Counsel's opinion) on the issues and prospects of success.",
                    additional_params: [],
                  },
                  {
                    code: "FM059",
                    meaning: "FHH Children",
                    description: "Limited to Family Help (Higher) and to all steps necessary to negotiate and conclude a settlement. To include the issue of proceedings and representation in those proceedings save in relation to or at a contested final hearing.",
                    additional_params: [],
                  },
                  {
                    code: "CV118",
                    meaning: "Hearing",
                    description: "Limited to all steps up to and including the hearing on [see additional limitation notes]",
                    additional_params: [
                      {
                        name: "hearing_date",
                        type: "date",
                        mandatory: true,
                      },
                    ],
                  },
                  {
                    code: "CV027",
                    meaning: "Hearing/Adjournment",
                    description: "Limited to all steps (including any adjournment thereof) up to and including the hearing on",
                    additional_params: [
                      {
                        name: "hearing_date",
                        type: "date",
                        mandatory: true,
                      },
                    ],
                  },
                  {
                    code: "CV117",
                    meaning: "Interim order inc. return date",
                    description: "Limited to all steps necessary to apply for an interim order; where application is made without notice to include representation on the return date.",
                    additional_params: [],
                  },
                  {
                    code: "FM015",
                    meaning: "Section 37 Report",
                    description: "Limited to a section 37 report only.",
                    additional_params: [],
                  },
                ],
              },
            }

          example "application/json",
                  :success,
                  expected_response,
                  "Successful request",
                  "Return details of level_of_service and scope_limitations for specified proceeding_type_ccms_code, delegated_functions_used, client_involvement_type and level_of_service_code"
          run_test! do |response|
            expect(response).to have_http_status(:success)
            expect(parsed_response).to eq expected_response
          end
        end

        response(400, "bad request") do
          let(:proceeding_type_scopes_query) do
            {
              proceeding_type_ccms_code: "XX123",
              delegated_functions_used: false,
              client_involvement_type: "A",
              level_of_service_code: 1,
            }
          end

          after do |example|
            example.metadata[:response][:content] = {
              "application/json": {
                examples: {
                  bad_request: {
                    value: JSON.parse(response.body, symbolize_names: true),
                    summary: "Bad request",
                    description: "When a non-existent ccms_code is sent, an error is generated from the json schema and returned",
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
end
