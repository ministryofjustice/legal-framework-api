require "rails_helper"

RSpec.describe ProceedingTypeServiceLevelsPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    before do
      # clear out seeded data - because it is transactional, the seeded data will be restored
      ProceedingTypeServiceLevel.all.map(&:destroy!)
    end

    specify { expect { call }.to change(ProceedingTypeServiceLevel, :count).from(0).to(166) }

    context "when filtered" do
      before { call }

      describe "by full rep and default" do
        let(:full_rep_default) { ProceedingTypeServiceLevel.where(service_level_id: ServiceLevel.find_by(level: 3).id, proceeding_default: true).count }

        it { expect(full_rep_default).to eq 146 }
      end

      describe "by full rep and non default" do
        let(:full_rep_non_default) { ProceedingTypeServiceLevel.where(service_level_id: ServiceLevel.find_by(level: 3).id, proceeding_default: false).count }

        before { call }

        it { expect(full_rep_non_default).to eq 10 }
      end

      describe "by FHH and default" do
        let(:fhh_default) { ProceedingTypeServiceLevel.where(service_level_id: ServiceLevel.find_by(level: 1).id, proceeding_default: true).count }

        before { call }

        it { expect(fhh_default).to eq 10 }
      end
    end
  end
end
