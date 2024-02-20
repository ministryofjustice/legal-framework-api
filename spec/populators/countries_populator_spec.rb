require "rails_helper"

RSpec.describe CountriesPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    before do
      Country.destroy_all
    end

    specify { expect { call }.to change(Country, :count).from(0).to(246) }
  end
end
