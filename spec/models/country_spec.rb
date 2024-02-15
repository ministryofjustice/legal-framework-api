require "rails_helper"

RSpec.describe Country do
  subject(:country) { create(:country) }

  describe "#validate" do
    it "validates presence of code" do
      country.code = ""
      expect(country).not_to be_valid
      expect(country.errors[:code]).to include("can't be blank")
    end

    it "validates presence of description" do
      country.description = ""
      expect(country).not_to be_valid
      expect(country.errors[:description]).to include("can't be blank")
    end
  end

  describe "#api_json" do
    subject(:api_json) { country.api_json }

    it "returns expected JSON response payload item" do
      expect(api_json).to eql({
        "code" => "GBR",
        "description" => "United Kingdom",
      })
    end
  end
end
