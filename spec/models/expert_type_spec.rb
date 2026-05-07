require "rails_helper"

RSpec.describe ExpertType do
  subject(:expert_type) { create(:expert_type) }

  describe "#validate" do
    it "validates presence of code" do
      expert_type.code = ""
      expect(expert_type).not_to be_valid
      expect(expert_type.errors[:code]).to include("can't be blank")
    end

    it "validates presence of description" do
      expert_type.description = ""
      expect(expert_type).not_to be_valid
      expect(expert_type.errors[:description]).to include("can't be blank")
    end
  end

  describe "#api_json" do
    subject(:api_json) { expert_type.api_json }

    it "returns expected JSON response payload item" do
      expect(api_json).to eql({
        "code" => expert_type.code,
        "description" => expert_type.description,
      })
    end
  end
end
