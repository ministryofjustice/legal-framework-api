require "rails_helper"

RSpec.describe ThresholdWaiverPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    context "when no threshold waivers exist" do
      before do
        ThresholdWaiver.delete_all
      end

      it "seeds all threshold waivers tasks" do
        expect { call }.to change(ThresholdWaiver, :count).from(0).to(1)
      end
    end

    context "when threshold waivers already exist" do
      it "does not add or remove threshold waivers" do
        expect { call }.not_to change(ThresholdWaiver, :count)
      end
    end
  end
end
