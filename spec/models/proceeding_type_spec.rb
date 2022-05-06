require "rails_helper"

RSpec.describe ProceedingType do
  include ActiveSupport::Testing::TimeHelpers

  it { is_expected.to have_many(:proceeding_type_service_levels).dependent(:destroy) }
  it { is_expected.to have_many(:service_levels).through(:proceeding_type_service_levels) }

  describe "#service_levels" do
    subject(:service_levels) { proceeding_type.service_levels }

    let(:proceeding_type) { create :proceeding_type }
    let!(:service_level1) { create :service_level }
    let!(:service_level2) { create :service_level }

    before do
      create(:proceeding_type_service_level, :as_default, proceeding_type:, service_level: service_level1)
      create(:proceeding_type_service_level, :as_non_default, proceeding_type:, service_level: service_level2)
      create(:service_level)
    end

    it "returns associated service levels only" do
      expect(service_levels).to match_array([service_level1, service_level2])
    end

    it "each service_level includes attribute `proceeding_default`" do
      expect(service_levels).to all(have_attributes(proceeding_default: be_in([true, false])))
    end

    it "each service_level responds to #proceeding_default" do
      expect(service_levels).to all(respond_to(:proceeding_default))
      expect(service_levels.map(&:proceeding_default)).to all(be_in([true, false]))
    end
  end

  context "when data has been seeded" do
    before { seed_live_data }

    describe "#matter_type" do
      it "returns the correct matter type record" do
        rec = described_class.find_by(ccms_code: "DA006")
        expect(rec.matter_type).to eq MatterType.domestic_abuse
      end
    end

    describe ".populate" do
      it "calls the proceeding_type_populator service" do
        expect(ProceedingTypePopulator).to receive(:call).with(no_args)
        described_class.populate
      end
    end

    describe "merits_tasks" do
      it "returns ordered list of all merits tasks" do
        rec = described_class.find_by(ccms_code: "DA003")
        tasks = rec.merits_tasks.pluck(:name)
        expect(tasks).to eq %w[latest_incident_details opponent_details statement_of_case chances_of_success]
      end
    end

    describe "application_tasks" do
      it "returns ordered list of application tasks only" do
        rec = described_class.find_by(ccms_code: "DA003")
        expect(rec.application_tasks.map(&:name)).to eq %w[latest_incident_details opponent_details statement_of_case]
      end
    end

    describe "proceeding_tasks" do
      it "returns ordered list of proceeding_level tasks only" do
        rec = described_class.find_by(ccms_code: "DA003")
        expect(rec.proceeding_tasks.map(&:name)).to eq %w[chances_of_success]
      end
    end

    context "with cost limitations" do
      let(:pt) { described_class.first }

      around do |example|
        travel_to run_date
        example.run
        travel_back
      end

      describe "before the change" do
        let(:run_date) { Date.parse("2021-09-11") }

        it "returns the old values" do
          expect(pt.default_cost_limitation_substantive).to eq 25_000.0
          expect(pt.default_cost_limitation_delegated_functions).to eq 1350.0
        end
      end

      describe "after the change" do
        let(:run_date) { Date.parse("2021-09-13") }

        it "returns the old values" do
          expect(pt.default_cost_limitation_substantive).to eq 25_000.0
          expect(pt.default_cost_limitation_delegated_functions).to eq 2250.0
        end
      end
    end
  end
end
