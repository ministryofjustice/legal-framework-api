require "rails_helper"

RSpec.describe ScopeLimitationsPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    before do
      # clear out existing Client Involvement Type data - because it is transactional, the seeded data will be restored
      ScopeLimitation.all.map(&:destroy!)
    end

    specify { expect { call }.to change(ScopeLimitation, :count).from(0).to(56) }
  end
end
