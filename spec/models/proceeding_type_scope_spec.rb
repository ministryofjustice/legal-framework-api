require "rails_helper"

RSpec.describe ProceedingTypeScope, type: :model do
  describe "validations" do
    subject(:record) do
      described_class.new(proceeding_type_ccms_code:,
                          service_level:,
                          client_involvement_type_code:,
                          df_used: true,
                          scope_limitation_code:,
                          default: false)
    end

    let(:proceeding_type_ccms_code) { "SE013" }
    let(:service_level) { 1 }
    let(:client_involvement_type_code) { "A" }
    let(:scope_limitation_code) { "CV117" }

    before do
      create :proceeding_type, ccms_code: "XX013"
    end

    context "with all fields valid" do
      it "is valid" do
        expect(record).to be_valid
      end
    end

    context "with invalid proceeding_type_code" do
      let(:proceeding_type_ccms_code) { "XX666" }

      it "is not valid" do
        expect(record).not_to be_valid
        expect(record.errors[:proceeding_type_ccms_code]).to include("Code XX666 doesn't exist on the proceeding_types table")
      end
    end

    context "with invalid service level" do
      let(:service_level) { 44 }

      it "is not valid" do
        expect(record).not_to be_valid
        expect(record.errors[:service_level]).to include("Service level 44 does not exist in the service_levels table")
      end
    end

    context "with client_involvement type" do
      let(:client_involvement_type_code) { "X" }

      it "is not valid" do
        expect(record).not_to be_valid
        expect(record.errors[:client_involvement_type_code]).to include("CCMS code X does not exist in the client_involvement_types table")
      end
    end

    context "with invalid scope limitation code" do
      let(:scope_limitation_code) { "ZZ999" }

      it "is not valid" do
        expect(record).not_to be_valid
        expect(record.errors[:scope_limitation_code]).to include("Scope Limitation ZZ999 does not exist in the scope_limitations table")
      end
    end

    context "with multiple defaults for one proceeding_type/service_level/client_involvement_type/df_used" do
      it "fails when I create a second default record in the same goup" do
        record = FactoryBot.build :proceeding_type_scope, :se013_cv119, default: true
        expect(record).not_to be_valid
        expect(record.errors[:default]).to include("There is already a default scope limitation for this group: SE013/1/A/false")
      end
    end
  end
end
