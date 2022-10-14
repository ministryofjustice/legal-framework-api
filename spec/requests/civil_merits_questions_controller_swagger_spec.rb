require "swagger_helper"

RSpec.describe "civil_merits_questions", type: :request do
  let(:data) do
    {
      request_id: "7d47425b-800a-41ef-a917-934acc09b50d",
      proceedings: [example_data],
    }
  end
  let(:example_data) do
    {
      ccms_code: "DA001",
      delegated_functions_used: true,
      client_involvement_type: "A",
    }
  end

  path "/civil_merits_questions" do
    post("Request civil merits questions for a set of proceedings") do
      description "Return questions base on proceeding codes, client involvement type and delegated function use"
      tags "Merits tasks"
      consumes "application/json"
      produces "application/json"
      parameter name: :data,
                in: :body,
                schema: {
                  type: :object,
                  required: %w[request_id proceedings],
                  description: "An array of proceeding data",
                  properties: {
                    request_id: { type: :string,
                                  example: "2a614e1a-a3d5-49ca-949a-c3248483d274",
                                  description: "Client generated request id that will be echoed back in the response" },
                    proceedings: {
                      type: :array,
                      description: "something something data",
                      items: {
                        type: :object,
                        required: %i[ccms_code delegated_function_used client_involvement_type],
                        properties: {
                          ccms_code: { type: :string,
                                       description: "A code uniquely identifying the proceeding_type",
                                       example: "SE013" },
                          delegated_functions_used: { type: :boolean,
                                                      description: "A boolean indicating whether delegated functions were used",
                                                      example: true },
                          client_involvement_type: { type: :string,
                                                     description: "A code uniquely identifying the client_involvement_type",
                                                     example: "A" },
                        },
                        description: "Array of CCMS codes, df_used and client involvement type of proceeding types to  be queried",
                      },
                    },
                  },
                }
      response(200, "successful") do
        context "when a single proceeding is requested without limiting" do
          expected_response =
            {
              request_id: "7d47425b-800a-41ef-a917-934acc09b50d",
              success: true,
              application: {
                tasks: {
                  latest_incident_details: [],
                  opponent_details: [],
                  statement_of_case: [],
                },
              },
              proceedings: [
                {
                  ccms_code: "DA001",
                  tasks: { chances_of_success: [] },
                },
              ],
            }
          example "application/json",
                  :success,
                  expected_response,
                  "Successful request",
                  "Request a single proceeding, DA001, without triggering any rules"
          run_test! do |response|
            expect(response).to have_http_status(:success)
            expect(parsed_response).to eq expected_response
          end
        end

        context "when requesting a domestic abuse proceeding for a non-applicant" do
          let(:example_data) do
            {
              ccms_code: "DA001",
              delegated_functions_used: true,
              client_involvement_type: "D",
            }
          end

          expected_response =
            {
              request_id: "7d47425b-800a-41ef-a917-934acc09b50d",
              success: true,
              application: {
                tasks: {
                  latest_incident_details: [],
                  opponent_details: [],
                  statement_of_case: [],
                  client_denial_of_allegation: [],
                  client_offer_of_undertakings: [],
                },
              },
              proceedings: [
                {
                  ccms_code: "DA001",
                  tasks: { chances_of_success: [] },
                },
              ],
            }
          example "application/json",
                  :success_with_rules,
                  expected_response,
                  "Successful request with extra questions",
                  "Request a single proceeding, DA001, triggering additional, domestic abuse, questions"
          run_test! do |response|
            expect(response).to have_http_status(:success)
            expect(parsed_response).to eq expected_response
          end
        end
      end

      response(400, "Bad request") do
        let(:example_data) do
          {
            ccms_code: "DA001",
            delegated_functions_used: true,
            client_involvement_type: "X",
          }
        end

        expected_response =
          {
            request_id: "7d47425b-800a-41ef-a917-934acc09b50d",
            success: false,
            errors: ["The property '#/proceedings/0/client_involvement_type' value \"X\" did not match one of the following values: A, D, W, Z, I in schema file://#"],
          }
        example "application/json",
                :invalid_cit,
                expected_response,
                "Invalid CIT",
                "User requests a non-existent client involvement type"

        run_test! do |response|
          expect(response.media_type).to eq("application/json")
          expect(parsed_response).to eq expected_response
        end
      end
    end
  end
end
