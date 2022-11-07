require "rails_helper"

RSpec.describe ProceedingTypeMeritsTaskPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    let(:proceeding_type_keys) { YAML.load_file(Rails.root.join("db/seed_data/proceeding_type_merits_task.yml")) }
    let(:seed_count) { proceeding_type_keys.map { |p| p["questions"].map { |q| q.is_a?(Hash) ? q.values.flatten.count : 1 }.sum }.sum }

    it "deletes all existing records" do
      expect(ProceedingTypeMeritsTask).to receive(:destroy_all)
      call
    end

    context "when run from an empty dataset" do
      before { ProceedingTypeMeritsTask.destroy_all }

      it "creates the same number of records as the seed data contains" do
        expect { call }.to change(ProceedingTypeMeritsTask, :count).to(seed_count)
      end
    end
  end
end
