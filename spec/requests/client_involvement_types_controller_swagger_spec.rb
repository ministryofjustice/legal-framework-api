require "swagger_helper"

RSpec.describe "client_involvement_types" do
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
          expect(JSON.parse(response.body)["client_involvement_type"].count).to eq 5
          expect(JSON.parse(response.body)["client_involvement_type"]).to eq expected_result
        end
      end
    end
  end

  path "/client_involvement_types/{proceeding_type_ccms_code}" do
    get("Show client involvement type for specific proceeding type") do
      parameter name: "proceeding_type_ccms_code",
                in: :path,
                type: :string,
                example: "DA001",
                description: "Proceeding_type_ccms_code, e.g. DA001"

      description "Returns an array of client involvement types with summary data for the specified proceeding type."

      tags "Client involvement types"

      produces "application/json"

      response(200, "successful") do
        let(:proceeding_type_ccms_code) { "DA001" }

        expected_result = {
          success: true,
          client_involvement_type: [
            { "ccms_code" => "A", "description" => "Applicant/claimant/petitioner" },
            { "ccms_code" => "D", "description" => "Defendant/respondent" },
            { "ccms_code" => "W", "description" => "Subject of proceedings (child)" },
            { "ccms_code" => "I", "description" => "Intervenor" },
            { "ccms_code" => "Z", "description" => "Joined party" },
          ],
        }

        example "application/json",
                :success,
                expected_result,
                "Successful request",
                "Returns an array of client involvement types with summary data for the specified proceeding type."

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body)["client_involvement_type"].count).to eq 5
          expect(JSON.parse(response.body)).to match_json_expression(expected_result)
        end
      end

      response(400, "bad request") do
        let(:proceeding_type_ccms_code) { "foobar" }

        expected_result = {
          success: false,
          message: "No such client involvement type: 'foobar'",
        }

        example "application/json",
                :bad_request,
                expected_result,
                "Bad request",
                "Returns success false and error message"

        run_test! do |response|
          expect(response).to have_http_status(:bad_request)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body)).to match_json_expression(expected_result)
        end
      end

      response(400, "bad request") do
        before do
          allow(ProceedingType).to receive(:find_by!).and_raise(ActiveRecord::ConnectionNotEstablished.new("could not establish a connection!"))
        end

        let(:proceeding_type_ccms_code) { "foobar" }

        expected_result = {
          success: false,
          message: "could not establish a connection!",
        }

        run_test! do |response|
          expect(response).to have_http_status(:bad_request)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body)).to match_json_expression(expected_result)
        end
      end
    end
  end
end
