require 'rails_helper'

RSpec.describe ThresholdWaiverService do
  before { seed_live_data }

  let(:request_id) { SecureRandom.uuid }

  subject { described_class.call(request_id, ccms_codes) }

  context 'successful_response' do
    context 'domestic abuse proceeding type' do
      let(:ccms_codes) { ['DA005'] }

      it 'returns valid response with expected tasks' do
        expect(subject).to eq expected_da005_response
      end
    end

    context 'domestic abuse and section 8 proceeding type' do
      let(:ccms_codes) { %w[DA005 SE003 SE013] }
      it 'returns response with dependencies' do
        expect(subject).to eq expected_da005_se003_se013_response
      end
    end
  end

  context 'error response' do
    context 'non_existent ccms_code' do
      let(:ccms_codes) { ['XX001'] }
      it 'returns error' do
        response = subject
        expect(response[:request_id]).to eq request_id
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq 'ActiveRecord::RecordNotFound'
        expect(response[:message]).to match "Couldn't find ProceedingType"
        expect(response[:backtrace]).to be_instance_of(Array)
      end
    end
    context 'no ccms codes specified' do
      let(:ccms_codes) { [] }
      it 'returns error' do
        response = subject
        expect(response[:request_id]).to eq request_id
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq 'ThresholdWaiverService::ThresholdWaiverServiceError'
        expect(response[:message]).to eq 'Must specify at least one proceeding type'
        expect(response[:backtrace]).to be_instance_of(Array)
      end
    end
  end

  def expected_da005_response
    {
      request_id: request_id,
      success: true,
      proceeding_types: [
        {
          code: 'DA005',
          capital_upper: true,
          disposable_income_upper: true,
          gross_income_upper: true,
          matter_type: 'Domestic abuse'
        }
      ]
    }
  end

  def expected_da005_se003_se013_response
    {
      request_id: request_id,
      success: true,
      proceeding_types: [
        {
          code: 'DA005',
          capital_upper: true,
          disposable_income_upper: true,
          gross_income_upper: true,
          matter_type: 'Domestic abuse'
        },
        {
          code: 'SE003',
          capital_upper: false,
          disposable_income_upper: false,
          gross_income_upper: false,
          matter_type: 'Children - section 8'
        },
        {
          code: 'SE013',
          capital_upper: false,
          disposable_income_upper: false,
          gross_income_upper: false,
          matter_type: 'Children - section 8'
        }
      ]
    }
  end
end
