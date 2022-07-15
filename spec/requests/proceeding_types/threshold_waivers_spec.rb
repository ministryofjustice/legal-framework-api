# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ProceedingTypes/ThresholdWaiversController", type: :request do
  describe "POST proceeding_types/threshold_waivers" do
    subject(:proceeding_types_threshold_post_request) { post proceeding_types_threshold_waivers_path, params: params.to_json, headers: }

    let(:request_id) { SecureRandom.uuid }
    let(:headers) { { "CONTENT_TYPE" => "application/json" } }
    let(:params) do
      {
        request_id:,
        proceeding_types:,
      }
    end
    let(:proceeding_types) { %w[DA005 SE004 SE013] }

    context "when the request is successful" do
      before { seed_live_data }

      let(:proceeding_types) { %w[DA005 SE004 SE013] }

      it "returns success" do
        proceeding_types_threshold_post_request
        expect(response).to have_http_status(:success)
      end

      it "returns the response supplied by the MeritsTaskService" do
        proceeding_types_threshold_post_request
        expect(JSON.parse(response.body)).to eq expected_successful_response
      end

      it "creates a request_history record" do
        expect { proceeding_types_threshold_post_request }.to change(RequestHistory, :count).by(1)
        history = RequestHistory.find_by(request_id:)
        expect(history.request_method).to eq "POST"
        expect(history.endpoint).to eq "/proceeding_types/threshold_waivers"

        expect(history.request_payload).to eq params.to_json
        expect(history.response_status).to eq 200
        expect(JSON.parse(history.response_payload)).to eq JSON.parse(expected_successful_response.to_json)
      end

      def expected_successful_response
        {
          request_id:,
          success: true,
          proceeding_types: [
            {
              ccms_code: "DA005",
              gross_income_upper: true,
              disposable_income_upper: true,
              capital_upper: true,
              matter_type: "Domestic abuse",
            },
            {
              ccms_code: "SE004",
              gross_income_upper: false,
              disposable_income_upper: false,
              capital_upper: false,
              matter_type: "Children - section 8",
            },
            {
              ccms_code: "SE013",
              gross_income_upper: false,
              disposable_income_upper: false,
              capital_upper: false,
              matter_type: "Children - section 8",
            },
          ],
        }.as_json
      end
    end

    context "when the request is unsuccessful" do
      before { seed_live_data }

      let(:proceeding_types) { %w[DA005 ZZ262 SE013] }

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
        expect(history.endpoint).to eq "/proceeding_types/threshold_waivers"
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
