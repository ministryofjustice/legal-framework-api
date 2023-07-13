require "rails_helper"

RSpec.describe OrganisationTypesPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    before do
      OrganisationType.destroy_all
    end

    specify { expect { call }.to change(OrganisationType, :count).from(0).to(14) }
  end
end
