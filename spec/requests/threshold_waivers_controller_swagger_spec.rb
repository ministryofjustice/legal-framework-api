require "swagger_helper"

RSpec.describe "threshold_waivers", type: :request do
  path "/threshold_waivers" do
    post("Return details of threshold waivers for specified proceeding type and client involvement type pairs identified by CCMS codes") do
      description "POST a JSON payload containing a request-id (a UUID generated by the client) and an array of
                   proceeding type and client involvement type CCMS code pairs to recieve a payload containing
                   the same request-id, and an array for each ccms_code pair submitted.<br/><br/>
                   Each item in the array will contain a list of Financial Eligibility assessment thresholds, and a value of true or false,
                   true meaning that the threshold is waived for this proceeding type and client involvement type (i.e unlimited) or false
                   to indicate that the threshold should be applied.  The matter type to which the proceeding belongs is also returned."

      let(:threshold_waiver_query) do
        {
          request_id: "ff9679d7-ca3e-40b8-a47e-5006895d9026",
          proceedings:,
        }
      end
      let(:proceedings) do
        [
          {
            ccms_code: "DA005",
            client_involvement_type: "A",
          },
          {
            ccms_code: "SE004",
            client_involvement_type: "D",
          },
        ]
      end

      tags "Threshold waivers"
      consumes "application/json"
      produces "application/json"
      parameter name: :threshold_waiver_query,
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    request_id: { type: :string,
                                  example: "ff9679d7-ca3e-40b8-a47e-5006895d9026",
                                  description: "Client generated request id that will be echoed back in the response" },
                    proceedings: { type: :array,
                                   items: [
                                     { type: :string, description: "CCMS codes of proceedings to be queried" },
                                     { type: :string, description: "CCMS codes of client involvement types to be queried" },
                                   ],
                                   example: [
                                     {
                                       ccms_code: "DA005",
                                       client_involvement_type: "A",
                                     },
                                     {
                                       ccms_code: "SE004",
                                       client_involvement_type: "D",
                                     },
                                   ] },
                  },
                  required: %w[request_id values],
                }
      response(200, "success") do
        expected_response =
          {
            request_id: "ff9679d7-ca3e-40b8-a47e-5006895d9026",
            success: true,
            proceedings: [
              {
                ccms_code: "DA005",
                full_s8_only: false,
                client_involvement_type: "A",
                gross_income_upper: true,
                disposable_income_upper: true,
                capital_upper: true,
                matter_type: "Domestic abuse",
              },
              {
                ccms_code: "SE004",
                full_s8_only: false,
                client_involvement_type: "D",
                gross_income_upper: false,
                disposable_income_upper: false,
                capital_upper: false,
                matter_type: "Children - section 8",
              },
            ],
          }

        example "application/json",
                :success,
                expected_response,
                "Successful request",
                "Return details of threshold waivers for specified proceeding type and client involvement type pairs identified by CCMS codes"
        run_test! do |response|
          expect(response).to have_http_status(:success)
          expect(parsed_response).to eq expected_response

          history = RequestHistory.find_by(request_id: "ff9679d7-ca3e-40b8-a47e-5006895d9026")
          expect(history.request_method).to eq "POST"
          expect(history.endpoint).to eq "/threshold_waivers"
          expect(history.request_payload).to match_json_expression threshold_waiver_query
          expect(history.response_status).to eq 200
          expect(history.response_payload).to match_json_expression expected_response
        end
      end

      response(400, "bad request") do
        let(:proceedings) do
          [
            {
              ccms_code: "DA005",
              client_involvement_type: "A",
            },
            {
              ccms_code: "ZZ262",
              client_involvement_type: "D",
            },
          ]
        end

        after do |example|
          example.metadata[:response][:content] = {
            "application/json": {
              examples: {
                bad_request: {
                  value: JSON.parse(response.body, symbolize_names: true),
                  summary: "Bad request",
                  description: "When a non-existent ccms_code is sent, an error is generated and returned",
                },
              },
            },
          }
        end

        run_test! do |response|
          expect(response).to have_http_status(:bad_request)
          expect(parsed_response[:success]).to be false
          expect(parsed_response[:error_class]).to eq "ActiveRecord::RecordNotFound"
          expect(parsed_response[:message]).to match "Couldn't find ProceedingType"
        end
      end
    end
  end
end