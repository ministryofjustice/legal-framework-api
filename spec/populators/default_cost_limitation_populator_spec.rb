require "rails_helper"

RSpec.describe DefaultCostLimitationPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    let(:dcl_keys) { YAML.load_file(Rails.root.join("db/seed_data/default_cost_limitations.yml")) }
    let(:seed_count) { dcl_keys.map { |p| p["questions"].map { |q| q.is_a?(Hash) ? q.values.flatten.count : 1 }.sum }.sum }

    it "deletes all existing records" do
      expect(DefaultCostLimitation).to receive(:destroy_all)
      call
    end

    it "creates new records" do
      # Note this tests for 3 records per proceeding type as, at the time of writing, each
      # proceeding type should have a single, substantive, DCL and two emergency DCLs
      # This will change if new proceedings are added or additional date changes are added to emergency or substantive grants
      call
      expect(DefaultCostLimitation.count).to eq 123
    end

    context "when a non-default value is set" do
      let(:se097a) { DefaultCostLimitation.find_by(proceeding_type: ProceedingType.find_by(ccms_code: "SE097A"), cost_type: "substantive") }

      before { call }

      it { expect(se097a.value).to eq 5_000 }
    end
  end
end
