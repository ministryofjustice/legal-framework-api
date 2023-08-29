require "rails_helper"

RSpec.describe OrganisationsPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    before do
      Organisation.destroy_all
    end

    specify { expect { call }.to change(Organisation, :count).from(0).to(1196) }
  end
end
