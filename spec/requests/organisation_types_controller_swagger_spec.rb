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
end
