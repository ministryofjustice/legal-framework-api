require "rails_helper"

RSpec.describe ProceedingTypeMeritsTaskPopulator do
  it { expect(described_class).to respond_to(:call) }
  it { expect(described_class.new).to respond_to(:call) }

  describe ".call" do
    subject(:call) { described_class.call }

    let(:proceeding_type_keys) { YAML.load_file(Rails.root.join("db/seed_data/proceeding_type_merits_task.yml")) }
    let(:seed_count) { proceeding_type_keys.sum { |p| p["questions"].sum { |q| q.is_a?(Hash) ? q.values.flatten.count : 1 } } }

    it "deletes all existing records" do
      expect(ProceedingTypeMeritsTask).to receive(:destroy_all)
      call
    end

    context "when the resulting data does not match the seed count" do
      before do
        ProceedingTypeMeritsTask.destroy_all
        proceeding_type = ProceedingType.find_by(ccms_code: "DA001")
        merits_task = MeritsTask.create!(name: "outdated_legacy", type: "ApplicationTask")
        # create a single record
        ProceedingTypeMeritsTask.create!(proceeding_type:,
                                         merits_task:,
                                         sequence: 990,
                                         display_rules: "should_have_been_deleted")

        allow(ProceedingTypeMeritsTask).to receive(:destroy_all).and_wrap_original do |method, _arg|
          method.call # call destroy all and create a single record
          ProceedingTypeMeritsTask.create!(proceeding_type:,
                                           merits_task:,
                                           sequence: 990,
                                           display_rules: "should_have_been_deleted")
        end
      end

      it "rolls back the error" do
        expect { call }.not_to change(ProceedingTypeMeritsTask, :count).from(1)
      end
    end

    context "when run from an empty dataset" do
      before { ProceedingTypeMeritsTask.destroy_all }

      it "creates the same number of records as the seed data contains" do
        expect { call }.to change(ProceedingTypeMeritsTask, :count).to(seed_count)
      end
    end
  end
end
