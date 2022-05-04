require "rails_helper"
require Rails.root.join("db/populators/service_levels_populator")

RSpec.describe ServiceLevelsPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    specify { expect { call }.to change(ServiceLevel, :count).from(0).to(2) }
  end
end
