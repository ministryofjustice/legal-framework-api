require 'rails_helper'

RSpec.describe ProceedingType do
  include ActiveSupport::Testing::TimeHelpers
  before { seed_live_data }

  describe '#matter_type' do
    it 'returns the correct matter type record' do
      rec = ProceedingType.find_by(ccms_code: 'DA006')
      expect(rec.matter_type).to eq MatterType.domestic_abuse
    end
  end

  describe '.populate' do
    it 'calls the proceeding_type_populator service' do
      expect(ProceedingTypePopulator).to receive(:call).with(no_args)
      described_class.populate
    end
  end

  describe 'merits_tasks' do
    it 'returns ordered list of all merits tasks' do
      rec = ProceedingType.find_by(ccms_code: 'DA003')
      tasks = rec.merits_tasks.pluck(:name)
      expect(tasks).to eq %w[latest_incident_details opponent_details statement_of_case chances_of_success]
    end
  end

  describe 'application_tasks' do
    it 'returns ordered list of application tasks only' do
      rec = ProceedingType.find_by(ccms_code: 'DA003')
      expect(rec.application_tasks.map(&:name)).to eq %w[latest_incident_details opponent_details statement_of_case]
    end
  end

  describe 'proceeding_tasks' do
    it 'returns ordered list of proceeding_level tasks only' do
      rec = ProceedingType.find_by(ccms_code: 'DA003')
      expect(rec.proceeding_tasks.map(&:name)).to eq %w[chances_of_success]
    end
  end

  context 'cost limitations' do
    let(:pt) { ProceedingType.first }

    around do |example|
      travel_to run_date
      example.run
      travel_back
    end

    describe 'before the change' do
      let(:run_date) { Date.parse('2021-09-11') }

      it 'returns the old values' do
        expect(pt.default_cost_limitation_substantive).to eq 25_000.0
        expect(pt.default_cost_limitation_delegated_functions).to eq 1350.0
      end
    end

    describe 'after the change' do
      let(:run_date) { Date.parse('2021-09-13') }

      it 'returns the old values' do
        expect(pt.default_cost_limitation_substantive).to eq 25_000.0
        expect(pt.default_cost_limitation_delegated_functions).to eq 2250.0
      end
    end
  end

  describe '.populate' do
    it 'calls the proceeding_type_populator service' do
      expect(ProceedingTypePopulator).to receive(:call).with(no_args)
      described_class.populate
    end
  end
end
