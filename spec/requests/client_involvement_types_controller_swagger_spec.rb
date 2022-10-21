require "swagger_helper"

RSpec.describe "client_involvement_types", type: :request do
  path "/client_involvement_types" do
    get("Get all client involvement types") do
      description "Returns an array of all client involvement types with summary data."

      tags "Client involvement types"

      produces "application/json"

      response(200, "successful") do
        expected_result = [
          { "ccms_code" => "A", "description" => "Applicant/claimant/petitioner" },
          { "ccms_code" => "D", "description" => "Defendant/respondent" },
          { "ccms_code" => "W", "description" => "Subject of proceedings (child)" },
          { "ccms_code" => "I", "description" => "Intervenor" },
          { "ccms_code" => "Z", "description" => "Joined party" },
        ]
        example "application/json",
                :success,
                expected_result,
                "Successful request",
                "Returns an array of all client involvement types with summary data."
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body).count).to eq 5
          expect(JSON.parse(response.body)).to eq expected_result
        end
      end
    end
  end
end
