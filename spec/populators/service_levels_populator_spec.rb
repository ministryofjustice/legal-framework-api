require "rails_helper"

RSpec.describe ServiceLevelsPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    before do
      # clear out existing Client Involvement Type data - because it is transactional, the seeded data will be restored
      ServiceLevel.all.map(&:destroy!)
    end

    specify { expect { call }.to change(ServiceLevel, :count).from(0).to(2) }
  end
end
