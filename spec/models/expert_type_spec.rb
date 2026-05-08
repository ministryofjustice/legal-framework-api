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

  describe "#by_matter_type" do
    let(:matter_type) { create(:matter_type, code: "TEST1") }
    let(:other_matter_type) { create(:matter_type, code: "TEST2") }
    let(:matched) { create(:expert_type, code: "MATCH", description: "Matched expert") }
    let(:unmatched) { create(:expert_type, code: "OTHER", description: "Unmatched expert") }

    before do
      create(:expert_type_matter_type, expert_type: matched, matter_type: matter_type)
      create(:expert_type_matter_type, expert_type: unmatched, matter_type: other_matter_type)
    end

    it "returns expert types associated with the given matter type code" do
      expect(described_class.for_matter_type("TEST1")).to contain_exactly(matched)
    end

    it "returns no expert types when no mapping exists for the matter type code" do
      expect(described_class.for_matter_type("UNKNOWN")).to be_empty
    end
  end
end
