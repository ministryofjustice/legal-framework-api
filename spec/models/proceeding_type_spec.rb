require "rails_helper"

RSpec.describe ProceedingType do
  include ActiveSupport::Testing::TimeHelpers

  it { is_expected.to have_many(:proceeding_type_service_levels).dependent(:destroy) }
  it { is_expected.to have_many(:service_levels).through(:proceeding_type_service_levels) }

  describe "#api_json" do
    subject(:api_json) { proceeding_type.api_json }

    let(:proceeding_type) { create(:proceeding_type) }

    it "returns the expected json key value pairs" do
      expect(api_json).to eql(
        {
          "ccms_code" => proceeding_type.ccms_code,
          "meaning" => proceeding_type.meaning,
          "description" => proceeding_type.description,
          "full_s8_only" => proceeding_type.full_s8_only,
          "ccms_category_law" => proceeding_type.matter_type.category_of_law,
          "ccms_matter_code" => proceeding_type.matter_type.code,
          "ccms_matter" => proceeding_type.matter_type.name,
        },
      )
    end
  end

  describe "#service_levels" do
    subject(:service_levels) { proceeding_type.service_levels }

    let(:proceeding_type) { described_class.find_by!(ccms_code: "SE013") }

    it "returns associated service levels only" do
      expect(service_levels.map(&:level)).to contain_exactly(1, 3)
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
    describe "#matter_type" do
      it "returns the correct matter type record" do
        rec = described_class.find_by(ccms_code: "DA006")
        expect(rec.matter_type).to eq MatterType.find_by(name: "Domestic abuse")
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
        expect(tasks).to eq %w[latest_incident_details opponent_name opponent_mental_capacity domestic_abuse_summary statement_of_case chances_of_success client_denial_of_allegation client_offer_of_undertakings nature_of_urgency opponents_application]
      end
    end

    describe "application_tasks" do
      it "returns ordered list of application tasks only" do
        rec = described_class.find_by(ccms_code: "DA003")
        expect(rec.application_tasks.map(&:name)).to eq %w[latest_incident_details opponent_name opponent_mental_capacity domestic_abuse_summary statement_of_case client_denial_of_allegation client_offer_of_undertakings nature_of_urgency]
      end
    end

    describe "proceeding_tasks" do
      it "returns ordered list of proceeding_level tasks only" do
        rec = described_class.find_by(ccms_code: "DA003")
        expect(rec.proceeding_tasks.map(&:name)).to eq %w[chances_of_success opponents_application]
      end
    end

    context "with cost limitations" do
      let(:pt) { described_class.find_by(ccms_code: "DA001") }

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
