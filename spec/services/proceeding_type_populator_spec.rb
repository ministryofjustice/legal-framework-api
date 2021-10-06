require 'rails_helper'

RSpec.describe ProceedingTypePopulator do
  before do
    MatterTypePopulator.call
    ProceedingType.delete_all
  end

  describe '#call' do
    let(:seed_file) { Rails.root.join('db/seed_data/proceeding_types.yml').freeze }

    it 'create instances from the seed file' do
      expect { described_class.call }.to change { ProceedingType.count }.by(12)
    end

    context 'when run twice' do
      it 'creates the same total number of proceeding_types' do
        expect {
          described_class.call
          described_class.call
        }.to change { ProceedingType.count }.by(12)
      end
    end
  end
end
