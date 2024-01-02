require "rails_helper"

RSpec.describe Organisation do
  subject(:organisation) { create(:organisation) }

  describe "#validate" do
    it "validates presence of name" do
      organisation.name = ""
      expect(organisation).not_to be_valid
      expect(organisation.errors[:name]).to include("can't be blank")
    end

    it "validates presence of ccms_code" do
      organisation.ccms_code = ""
      expect(organisation).not_to be_valid
      expect(organisation.errors[:ccms_code]).to include("can't be blank")
    end

    it "validates presence of searchable_type" do
      organisation.searchable_type = ""
      expect(organisation).not_to be_valid
      expect(organisation.errors[:searchable_type]).to include("can't be blank")
    end
  end

  describe "#api_json" do
    subject(:api_json) { organisation.api_json }

    it "returns expected JSON response payload item" do
      expect(api_json).to eql({
        "name" => "Angus Council",
        "ccms_opponent_id" => "280361",
        "ccms_type_code" => "LA",
        "ccms_type_text" => "Local Authority",
      })
    end
  end
end
