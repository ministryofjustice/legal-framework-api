require "rails_helper"

RSpec.describe ExpertTypeMatterType do
  describe "associations" do
    it { is_expected.to belong_to(:expert_type) }
    it { is_expected.to belong_to(:matter_type) }
  end

  describe "validations" do
    it "validates uniqueness of expert_type scoped to matter_type" do
      existing = create(:expert_type_matter_type)
      duplicate = build(:expert_type_matter_type, expert_type: existing.expert_type, matter_type: existing.matter_type)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:expert_type_id]).to include("has already been taken")
    end
  end
end
