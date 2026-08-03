require "rails_helper"

RSpec.describe ExpertTypeMatterTypesPopulator do
  describe ".call" do
    subject(:call) { described_class.call }

    before do
      MatterType.find_or_create_by!(code: "KPBLW") do |mt|
        mt.name = "Special Children Act"
      end
      ExpertTypesPopulator.call
      ExpertTypeMatterType.destroy_all
    end

    it "creates join records between matter types and expert types" do
      expect { call }.to change(ExpertTypeMatterType, :count).from(0).to(15)
    end

    it "runs idempotently without creating duplicates" do
      described_class.call
      expect { call }.not_to change(ExpertTypeMatterType, :count)
    end

    context "when a matter type in the seed data is missing from the database" do
      before do
        allow(YAML).to receive(:load_file).and_return([
          { "matter_type_code" => "NON_EXISTENT_MT", "expert_type_codes" => %w[SOME_ET] },
        ])
      end

      it "raises an error" do
        expect { call }.to raise_error(RuntimeError, "MatterType with code 'NON_EXISTENT_MT' not found")
      end
    end

    context "when an expert type in the seed data is missing from the database" do
      before do
        allow(YAML).to receive(:load_file).and_return([
          { "matter_type_code" => "KPBLW", "expert_type_codes" => %w[NON_EXISTENT_ET] },
        ])
      end

      it "raises an error" do
        expect { call }.to raise_error(RuntimeError, "ExpertType with code 'NON_EXISTENT_ET' not found")
      end
    end
  end
end
