require "rails_helper"

RSpec.describe ScopeLimitation do
  let(:pt_ccms_code) { "SE013" }
  let(:service_level) { 1 }
  let(:client_involvement_type) { "A" }
  let(:df_used) { true }

  describe ".eligible_for" do
    subject(:actual_codes) { described_class.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used).pluck(:code) }

    context "with service level 1" do
      it "returns all the correct scope limitation records" do
        expected_codes = %w[CV027 CV079 CV117 CV118 FM004 FM007 FM015 FM019]
        expect(actual_codes).to match_array(expected_codes)
      end
    end

    context "with service level 3" do
      let(:service_level) { 3 }

      it "returns all the correct scope limitation records for service level 3" do
        expected_codes = %w[CV027 CV117 CV118 FM007 FM019 FM039 FM049]
        expect(actual_codes).to match_array(expected_codes)
      end
    end
  end

  describe ".default_for" do
    subject(:default_scope) { described_class.default_for(pt_ccms_code, client_involvement_type, service_level, df_used) }

    let(:expected_scope) { described_class.find_by(code: expected_code) }

    context "with SE013, service_level 1, client involvement type A, df used" do
      let(:service_level) { 1 }
      let(:client_involvement_type) { "A" }
      let(:df_used) { true }
      let(:expected_code) { "CV117" }

      it "returns the expected ScopeLimitation" do
        expect(default_scope).to eq expected_scope
      end
    end

    context "with SE013, service_level 1, client involvement type A, substantive" do
      let(:service_level) { 1 }
      let(:client_involvement_type) { "A" }

      let(:df_used) { false }
      let(:expected_code) { "FM059" }

      it "returns the expected ScopeLimitation" do
        expect(default_scope).to eq expected_scope
      end
    end

    context "with SE013, service_level 1, client involvement type D, df used" do
      let(:service_level) { 1 }

      let(:df_used) { true }
      let(:client_involvement_type) { "D" }
      let(:expected_code) { "CV118" }

      it "returns the expected ScopeLimitation" do
        expect(default_scope).to eq expected_scope
      end
    end

    context "with SE013, service_level 1, client involvement type D, substantive" do
      let(:service_level) { 1 }

      let(:client_involvement_type) { "D" }
      let(:df_used) { false }
      let(:expected_code) { "FM059" }

      it "returns the expected ScopeLimitation" do
        expect(default_scope).to eq expected_scope
      end
    end

    context "with SE013, service_level 3, client involvement type A, df used" do
      let(:client_involvement_type) { "A" }
      let(:df_used) { true }
      let(:expected_code) { "CV117" }
      let(:service_level) { 3 }

      it "returns the expected ScopeLimitation" do
        expect(default_scope).to eq expected_scope
      end
    end

    context "with SE013, service_level 3, client involvement type A, substantive" do
      let(:client_involvement_type) { "A" }

      let(:service_level) { 3 }
      let(:df_used) { false }
      let(:expected_code) { "FM049" }

      it "returns the expected ScopeLimitation" do
        expect(default_scope).to eq expected_scope
      end
    end

    context "with SE013, service_level 3, client involvement type D, df used" do
      let(:service_level) { 3 }
      let(:client_involvement_type) { "D" }
      let(:df_used) { true }
      let(:expected_code) { "CV118" }

      it "returns the expected ScopeLimitation" do
        expect(default_scope).to eq expected_scope
      end
    end

    context "with SE013, service_level 3, client involvement type D, substantive" do
      let(:df_used) { false }
      let(:client_involvement_type) { "D" }
      let(:service_level) { 3 }
      let(:expected_code) { "FM049" }

      it "returns the expected ScopeLimitation" do
        expect(default_scope).to eq expected_scope
      end
    end
  end

  describe "user_inputs" do
    let(:hearing_date) { ScopeUserInput.find_by(input_name: "hearing_date") }
    let(:limitation_note) { ScopeUserInput.find_by(input_name: "limitation_note") }
    let(:scope) { create(:scope_limitation) }

    context "when adding new user inputs" do
      it "creates a record in the join table" do
        expect { scope.user_inputs << hearing_date }.to change(ScopeLimitationUserInput, :count).by(1)
      end
    end

    context "when retrieving user inputs" do
      before do
        scope.user_inputs << hearing_date
        scope.user_inputs << limitation_note
      end

      it "returns both user input records" do
        expect(scope.user_inputs).to contain_exactly(hearing_date, limitation_note)
      end
    end
  end

  def populate_seed_data
    MatterTypePopulator.call
    ProceedingType.populate
    ScopeLimitationsPopulator.call
    ServiceLevelsPopulator.call
    ClientInvolvementTypesPopulator.call
    ProceedingTypeScopePopulator.call
  end
end
