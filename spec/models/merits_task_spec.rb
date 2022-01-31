require "rails_helper"

RSpec.describe MeritsTask do
  before { seed_live_data }

  describe "#dependencies" do
    context "task with no dependencies" do
      it "returns and empty collection" do
        task = described_class.find_by!(name: "opponent_details")
        expect(task.dependencies).to be_empty
      end
    end

    context "task with dependencies" do
      it "returns a collection of dependencies" do
        task = described_class.find_by!(name: "children_proceeding")
        expect(task.dependencies.map(&:name)).to eq(%w[children_application])
      end
    end
  end
end
