# frozen_string_literal: true

require "rails_helper"

RSpec.describe MeritsTasksController, type: :request do
  describe "POST /merits_tasks" do
    subject(:merits_tasks_post_request) { post merits_tasks_path, params: params.to_json, headers: }

    let(:request_id) { SecureRandom.uuid }
    let(:headers) { { "CONTENT_TYPE" => "application/json" } }
    let(:params) do
      {
        request_id:,
        proceeding_types:,
      }
    end

    context "when the request is successful" do
      let(:proceeding_types) { %w[DA005 SE004 SE013] }

      it "returns success" do
        merits_tasks_post_request
        expect(response).to have_http_status(:success)
      end

      it "returns the response supplied by the MeritsTaskService" do
        merits_tasks_post_request
        expect(response.body).to eq expected_successful_response.to_json
      end

      it "creates a request_history record" do
        expect { merits_tasks_post_request }.to change(RequestHistory, :count).by(1)
        history = RequestHistory.find_by(request_id:)
        expect(history.request_method).to eq "POST"
        expect(history.endpoint).to eq "/merits_tasks"

        expect(history.request_payload).to eq params.to_json
        expect(history.response_status).to eq 200
        expect(history.response_payload).to eq expected_successful_response.to_json
      end

      def expected_successful_response
        {
          request_id:,
          success: true,
          application: {
            tasks: {
              "latest_incident_details" => [],
              "opponent_details" => [],
              "statement_of_case" => [],
              "children_application" => [],
            },
          },
          proceeding_types: [
            {
              ccms_code: "DA005",
              tasks: {
                "chances_of_success" => [],
              },
            },
            {
              ccms_code: "SE004",
              tasks: {
                "chances_of_success" => [],
                "children_proceeding" => %w[children_application],
                "attempts_to_settle" => [],
              },
            },
            {
              ccms_code: "SE013",
              tasks: {
                "chances_of_success" => [],
                "children_proceeding" => %w[children_application],
                "attempts_to_settle" => [],
              },
            },
          ],
        }
      end
    end

    context "when the request is unsuccessful" do
      let(:proceeding_types) { %w[DA005 ZZ262 SE013] }

      it "returns bad request" do
        merits_tasks_post_request
        expect(response.status).to eq 400
      end

      it "returns expected error response" do
        merits_tasks_post_request
        expect(parsed_response[:request_id]).to eq request_id
        expect(parsed_response[:success]).to be false
        expect(parsed_response[:error_class]).to eq "ActiveRecord::RecordNotFound"
        expect(parsed_response[:message]).to match(/Couldn't find ProceedingType/)
        expect(parsed_response[:backtrace]).to be_instance_of(Array)
      end

      it "records the result in the request history table" do
        expect { merits_tasks_post_request }.to change(RequestHistory, :count).by(1)
        history = RequestHistory.find_by(request_id:)
        expect(history.request_method).to eq "POST"
        expect(history.endpoint).to eq "/merits_tasks"
        expect(history.request_payload).to eq params.to_json
        expect(history.response_status).to eq 400
        stored_response = JSON.parse(history.response_payload, symbolize_names: true)
        expect(stored_response[:request_id]).to eq request_id
        expect(stored_response[:success]).to be false
        expect(stored_response[:error_class]).to eq "ActiveRecord::RecordNotFound"
        expect(stored_response[:message]).to match(/Couldn't find ProceedingType/)
        expect(stored_response[:backtrace]).to be_instance_of(Array)
      end
    end
  end
end
