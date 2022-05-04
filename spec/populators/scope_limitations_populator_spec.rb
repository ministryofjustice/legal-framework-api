require "rails_helper"
require Rails.root.join("db/populators/scope_limitations_populator")

RSpec.describe ScopeLimitationsPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    specify { expect { call }.to change(ScopeLimitation, :count).from(0).to(16) }
  end
end
