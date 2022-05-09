require "rails_helper"

RSpec.describe ProceedingTypeServiceLevelsPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    before do
      MatterTypePopulator.call
      ServiceLevelsPopulator.call
      ProceedingTypePopulator.call
    end

    specify { expect { call }.to change(ProceedingTypeServiceLevel, :count).from(0).to(16) }
  end
end
