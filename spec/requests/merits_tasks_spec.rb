# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MeritsTasksController, type: :request do
  describe 'POST /merits_tasks' do
    let(:request_id) { SecureRandom.uuid }
    let(:params) do
      {
        request_id: request_id,
        proceeding_types: proceeding_types
      }
    end

    subject{ post merits_tasks_path, params: params }

    context 'successful request' do

      before { seed_live_data }

      let(:proceeding_types) { %w[DA005 SE004 SE013] }

      it 'returns success', :show_in_doc, doc_title: 'POST Error Response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'returns the response supplied by the MeritsTaskService' do
        subject
        expect(response.body).to eq expected_successful_response.to_json
      end

      it 'creates a request_history record' do
        expect{subject}.to change{RequestHistory.count}.by(1)
        history = RequestHistory.find_by(request_id: request_id)
        expect(history.request_method).to eq 'POST'
        expect(history.endpoint).to eq '/merits_tasks'
        expect(history.request_payload).to eq params.to_json
        expect(history.response_status).to eq 200
        expect(history.response_payload).to eq expected_successful_response.to_json
      end

      def expected_successful_response
        {
          request_id: request_id,
          success: true,
          application: {
            tasks: {
              'latest_incident_details' => [],
              'opponent_details' => [],
              'statement_of_case' => [],
              'children_application' => []
            }
          },
          proceeding_types: [
            {
              ccms_code: 'DA005',
              'chances_of_success' => []
            },
            {
              ccms_code: 'SE004',
              'chances_of_success' => [],
              'children_proceeding' => ['children_application']
            },
            {
              ccms_code: 'SE013',
              'chances_of_success' => [],
              'children_proceeding' => ['children_application']
            }
          ]
        }
      end
    end

    context 'unsuccessful_request' do
      let(:proceeding_types) { %w[DA005 XX262 SE013] }

      it 'returns bad request', :show_in_doc, doc_title: 'POST Error Response' do
        subject
        expect(response.status).to eq 400
      end

      it 'returns expected error response' do
        subject
        expect(parsed_response[:request_id]).to eq request_id
        expect(parsed_response[:success]).to be false
        expect(parsed_response[:error_class]).to eq 'ActiveRecord::RecordNotFound'
        expect(parsed_response[:message]).to eq "Couldn't find ProceedingType"
        expect(parsed_response[:backtrace]).to be_instance_of(Array)
      end

      it 'records the result in the request history table' do
        expect{subject}.to change{RequestHistory.count}.by(1)
        history = RequestHistory.find_by(request_id: request_id)
        expect(history.request_method).to eq 'POST'
        expect(history.endpoint).to eq '/merits_tasks'
        expect(history.request_payload).to eq params.to_json
        expect(history.response_status).to eq 400
        stored_response = JSON.parse(history.response_payload, symbolize_names: true)
        expect(stored_response[:request_id]).to eq request_id
        expect(stored_response[:success]).to be false
        expect(stored_response[:error_class]).to eq 'ActiveRecord::RecordNotFound'
        expect(stored_response[:message]).to eq "Couldn't find ProceedingType"
        expect(stored_response[:backtrace]).to be_instance_of(Array)
      end
    end
  end
end


