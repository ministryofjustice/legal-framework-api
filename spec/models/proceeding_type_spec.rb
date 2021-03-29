require 'rails_helper'

RSpec.describe ProceedingType do
  before do
    Dir[Rails.root.join('db/seed_files/*.rb')].sort.each do |seed_file|
      require seed_file
    end

    MatterTypePopulator.call
    ProceedingTypePopulator.call
    MeritsTaskPopulator.call
    ProceedingTypeMeritsTaskPopulator.call
  end

  describe '#matter_type' do
    it 'returns the correct matter type record' do
      rec = ProceedingType.find_by(ccms_code: 'DA006')
      expect(rec.matter_type).to eq MatterType.domestic_abuse
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
end
