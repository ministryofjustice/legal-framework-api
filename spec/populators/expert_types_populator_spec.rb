require "rails_helper"

RSpec.describe ExpertTypesPopulator do
  describe ".call" do
    subject(:call) { described_class.call }

    before do
      ExpertType.destroy_all
    end

    it "creates expert type records from the seed file" do
      expect { call }.to change(ExpertType, :count).by(26)
    end

    it "updates existing records without creating duplicates" do
      described_class.call
      expect { call }.not_to change(ExpertType, :count)
    end
  end
end
