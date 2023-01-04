require "rails_helper"

RSpec.describe MatterType do
  describe "finders" do
    describe ".domestic_abuse" do
      it "returns the domestic abuse record" do
        expect(described_class.domestic_abuse.name).to eq "Domestic Abuse"
      end
    end

    describe ".section8" do
      it "returns the section8 record" do
        expect(described_class.section8.name).to eq "Section 8 orders"
      end
    end
  end
end
