require 'rails_helper'

RSpec.describe ProceedingTypeService do
  subject { described_class.call(ccms_code) }

  before { seed_live_data }

  context 'successful_response' do
    let(:ccms_code) { %w[DA003] }

    it 'returns valid response with expected tasks' do
      expect(subject).to eq expected_da003_response
    end
  end

  context 'error response' do
    context 'non_existent ccms_code' do
      let(:ccms_code) { 'XX001' }

      it 'returns error' do
        response = subject
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq 'ActiveRecord::RecordNotFound'
        expect(response[:message]).to match(/Couldn't find ProceedingType/)
        expect(response[:backtrace]).to be_instance_of(Array)
      end
    end

    context 'no ccms codes specified' do
      let(:ccms_code) { nil }

      it 'returns error' do
        response = subject
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq 'ProceedingTypeService::ProceedingTypeServiceError'
        expect(response[:message]).to eq 'Must specify a proceeding type'
        expect(response[:backtrace]).to be_instance_of(Array)
      end
    end
  end

  def expected_da003_response
    {
      success: true,
      ccms_code: 'DA003',
      name: 'harassment_injunction',
      meaning: 'Harassment - injunction',
      ccms_category_law_code: 'MAT',
      ccms_matter_code: 'MINJN',
      description: 'to be represented in an action for an injunction under'\
                   ' section 3 Protection from Harassment Act 1997.',
      ccms_category_law: 'Family',
      ccms_matter: 'Domestic abuse',
      cost_limitations: {
        substantive: {
          start_date: '1970-01-01',
          value: '25000.0',
        },
        delegated_functions: {
          start_date: '2021-09-13',
          value: '2250.0',
        },
      },
      default_scope_limitations: {
        substantive: {
          code: 'AA019',
          meaning: 'Injunction FLA-to final hearing',
          description: 'As to proceedings under Part IV Family Law Act 1996'\
                       ' limited to all steps up to and including obtaining and'\
                       ' serving a final order and in the event of breach leading'\
                       ' to the exercise of a power of arrest to representation on'\
                       ' the consideration of the breach by the court (but excluding'\
                       ' applying for a warrant of arrest, if not attached, and'\
                       ' representation in contempt proceedings).',
        },
        delegated_functions: {
          code: 'CV117',
          meaning: 'Interim order inc. return date',
          description: 'Limited to all steps necessary to apply for an interim order;'\
                       ' where application is made without notice to include representation on the return date.',
        },
      },
    }
  end
end
