require "swagger_helper"

RSpec.describe "organisation_types" do
  path "/organisation_types/all" do
    get("Get all organisation types") do
      description "Returns an array of all organisation types with ccms codes."

      tags "Organisation types"

      produces "application/json"

      response(200, "successful") do
        expected_result = [
          { "ccms_code" => "CHAR", "description" => "Charity" },
          { "ccms_code" => "CO", "description" => "Court" },
          { "ccms_code" => "GOVT", "description" => "Government Department" },
          { "ccms_code" => "HMO", "description" => "HM Prison or Young Offender Institute" },
          { "ccms_code" => "HOA", "description" => "Housing Association" },
          { "ccms_code" => "IRC", "description" => "Immigration Removal Centre" },
          { "ccms_code" => "LTD", "description" => "Limited Company" },
          { "ccms_code" => "LLP", "description" => "Limited Liability Partnership" },
          { "ccms_code" => "LA", "description" => "Local Authority" },
          { "ccms_code" => "NHS", "description" => "National Health Service" },
          { "ccms_code" => "PART", "description" => "Partnership" },
          { "ccms_code" => "POLICE", "description" => "Police Authority" },
          { "ccms_code" => "PLC", "description" => "Public Limited Company" },
          { "ccms_code" => "SOLE", "description" => "Sole Trader" },
        ]

        example "application/json",
                :success,
                expected_result,
                "Successful request",
                "Returns an array of all organisation types with ccms codes."
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body).count).to eq 14
          expect(JSON.parse(response.body)).to eq expected_result
        end
      end
    end
  end

  path "/organisation_types/{ccms_code}" do
    get("Show details for a single organisation type") do
      let(:ccms_code) { "CHAR" }
      parameter name: "ccms_code",
                in: :path,
                type: :string,
                example: "CHAR",
                description: "CCMS code, e.g. CO or GOVT"

      description "Return details for specified organisation type"
      tags "Organisation types"

      produces "application/json"

      response(200, "successful") do
        expected_response =
          {
            success: true,
            organisation_type: {
              ccms_code: "CHAR",
              description: "Charity",
            },
          }
        example "application/json",
                :success,
                expected_response,
                "Successful request",
                "Return details for specified organisation type"
        run_test! do |response|
          expect(response).to have_http_status(:success)
          expect(response.body).to eq expected_response.to_json
        end
      end

      response(400, "Bad request") do
        let(:ccms_code) { "AZ123" }

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
          expect(parsed_response[:message]).to match "No such organisation type: 'AZ123'"
        end
      end
    end
  end
end
