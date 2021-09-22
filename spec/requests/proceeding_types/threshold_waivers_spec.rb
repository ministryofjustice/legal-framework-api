# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ProceedingTypes/ThresholdWaiversController', type: :request do
  describe 'POST proceeding_types/threshold_waivers' do
    let(:request_id) { SecureRandom.uuid }
    let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
    let(:params) do
      {
        request_id: request_id,
        proceeding_types: proceeding_types
      }
    end
    let(:proceeding_types) { %w[DA005 SE004 SE013] }

    subject { post proceeding_types_threshold_waivers_path, params: params.to_json, headers: headers }

    context 'successful request' do
      before { seed_live_data }

      let(:proceeding_types) { %w[DA005 SE004 SE013] }

      it 'returns success', :show_in_doc do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'returns the response supplied by the MeritsTaskService' do
        subject
        expect(response.body).to eq expected_successful_response.to_json
      end

      it 'creates a request_history record' do
        expect { subject }.to change { RequestHistory.count }.by(1)
        history = RequestHistory.find_by(request_id: request_id)
        expect(history.request_method).to eq 'POST'
        expect(history.endpoint).to eq '/proceeding_types/threshold_waivers'

        expect(history.request_payload).to eq params.to_json
        expect(history.response_status).to eq 200
        expect(history.response_payload).to eq expected_successful_response.to_json
      end

      def expected_successful_response
        {
          request_id: request_id,
          success: true,
          proceeding_types: [
            {
              ccms_code: 'DA005',
              gross_income_upper: true,
              disposable_income_upper: true,
              capital_upper: true,
              matter_type: 'Domestic abuse'
            },
            {
              ccms_code: 'SE004',
              gross_income_upper: false,
              disposable_income_upper: false,
              capital_upper: false,
              matter_type: 'Children - section 8'
            },
            {
              ccms_code: 'SE013',
              gross_income_upper: false,
              disposable_income_upper: false,
              capital_upper: false,
              matter_type: 'Children - section 8'
            }
          ]
        }
      end
    end

    context 'unsuccessful_request' do
      before { seed_live_data }
      let(:proceeding_types) { %w[DA005 ZZ262 SE013] }

      it 'returns bad request', :show_in_doc do
        subject
        expect(response.status).to eq 400
      end

      it 'returns expected error response' do
        subject
        expect(parsed_response[:request_id]).to eq request_id
        expect(parsed_response[:success]).to be false
        expect(parsed_response[:error_class]).to eq 'ActiveRecord::RecordNotFound'
        expect(parsed_response[:message]).to match "Couldn't find ProceedingType"
        expect(parsed_response[:backtrace]).to be_instance_of(Array)
      end

      it 'records the result in the request history table' do
        expect { subject }.to change { RequestHistory.count }.by(1)
        history = RequestHistory.find_by(request_id: request_id)
        expect(history.request_method).to eq 'POST'
        expect(history.endpoint).to eq '/proceeding_types/threshold_waivers'
        expect(history.request_payload).to eq params.to_json
        expect(history.response_status).to eq 400
        stored_response = JSON.parse(history.response_payload, symbolize_names: true)
        expect(stored_response[:request_id]).to eq request_id
        expect(stored_response[:success]).to be false
        expect(stored_response[:error_class]).to eq 'ActiveRecord::RecordNotFound'
        expect(stored_response[:message]).to match "Couldn't find ProceedingType"
        expect(stored_response[:backtrace]).to be_instance_of(Array)
      end
    end
  end
end
