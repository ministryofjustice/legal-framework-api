require "rails_helper"

RSpec.describe "ThresholdWaiversController", type: :request do
  describe "POST threshold_waivers" do
    subject(:proceeding_types_threshold_post_request) { post threshold_waivers_path, params: params.to_json, headers: }

    let(:request_id) { SecureRandom.uuid }
    let(:headers) { { "CONTENT_TYPE" => "application/json" } }
    let(:params) do
      {
        request_id:,
        proceedings: proceeding_types_with_client_involvement_types,
      }
    end
    let(:proceeding_types_with_client_involvement_types) do
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

    context "when the request is successful" do
      before { seed_live_data }

      it "returns success" do
        proceeding_types_threshold_post_request
        expect(response).to have_http_status(:success)
      end

      it "returns the expected response" do
        proceeding_types_threshold_post_request
        expect(JSON.parse(response.body)).to eq JSON.parse(expected_successful_response.to_json)
      end

      it "creates a request_history record" do
        expect { proceeding_types_threshold_post_request }.to change(RequestHistory, :count).by(1)
        history = RequestHistory.find_by(request_id:)
        expect(history.request_method).to eq "POST"
        expect(history.endpoint).to eq "/threshold_waivers"

        expect(history.request_payload).to eq params.to_json
        expect(history.response_status).to eq 200
        expect(JSON.parse(history.response_payload)).to eq JSON.parse(expected_successful_response.to_json)
      end

      def expected_successful_response
        {
          request_id:,
          success: true,
          proceedings: [
            {
              ccms_code: "DA005",
              client_involvement_type: "A",
              gross_income_upper: true,
              disposable_income_upper: true,
              capital_upper: true,
              matter_type: "Domestic abuse",
            },
            {
              ccms_code: "SE004",
              client_involvement_type: "D",
              gross_income_upper: false,
              disposable_income_upper: false,
              capital_upper: false,
              matter_type: "Children - section 8",
            },
          ],
        }
      end
    end

    context "when the request is unsuccessful" do
      before { seed_live_data }

      let(:proceeding_types_with_client_involvement_types) do
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

      it "returns bad request" do
        proceeding_types_threshold_post_request
        expect(response.status).to eq 400
      end

      it "returns expected error response" do
        proceeding_types_threshold_post_request
        expect(parsed_response[:request_id]).to eq request_id
        expect(parsed_response[:success]).to be false
        expect(parsed_response[:error_class]).to eq "ActiveRecord::RecordNotFound"
        expect(parsed_response[:message]).to match "Couldn't find ProceedingType"
        expect(parsed_response[:backtrace]).to be_instance_of(Array)
      end

      it "records the result in the request history table" do
        expect { proceeding_types_threshold_post_request }.to change(RequestHistory, :count).by(1)
        history = RequestHistory.find_by(request_id:)
        expect(history.request_method).to eq "POST"
        expect(history.endpoint).to eq "/threshold_waivers"
        expect(history.request_payload).to eq params.to_json
        expect(history.response_status).to eq 400
        stored_response = JSON.parse(history.response_payload, symbolize_names: true)
        expect(stored_response[:request_id]).to eq request_id
        expect(stored_response[:success]).to be false
        expect(stored_response[:error_class]).to eq "ActiveRecord::RecordNotFound"
        expect(stored_response[:message]).to match "Couldn't find ProceedingType"
        expect(stored_response[:backtrace]).to be_instance_of(Array)
      end
    end
  end
end
