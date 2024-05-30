require "rails_helper"

RSpec.describe MatterTypePopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    before do
      ThresholdWaiver.all.map(&:destroy!)
      MatterType.all.map(&:destroy!)
    end

    specify { expect { call }.to change(MatterType, :count).from(0).to(3) }
  end
end
