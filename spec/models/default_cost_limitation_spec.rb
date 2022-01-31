require "rails_helper"

RSpec.describe DefaultCostLimitation do
  before { seed_live_data }

  describe "#cost_type" do
    it "does not allow invalid cost types" do
      expect {
        described_class.create!(proceeding_type: ProceedingType.first, cost_type: "xxxx", start_date: 1.month.ago, value: 55)
      }.to raise_error ArgumentError, "'xxxx' is not a valid cost_type"
    end
  end

  describe ".for_date(date)" do
    context "before change date" do
      let(:date) { Date.parse("2021-09-12") }

      it "returns the old value" do
        dcl = described_class.delegated_functions.for_date(date)
        expect(dcl.value).to eq 1350
      end
    end

    context "on change date" do
      let(:date) { Date.parse("2021-09-13") }

      it "returns the old value" do
        dcl = described_class.delegated_functions.for_date(date)
        expect(dcl.value).to eq 2250
      end
    end

    context "on change date" do
      let(:date) { Date.parse("2021-09-19") }

      it "returns the old value" do
        dcl = described_class.delegated_functions.for_date(date)
        expect(dcl.value).to eq 2250
      end
    end
  end
end
