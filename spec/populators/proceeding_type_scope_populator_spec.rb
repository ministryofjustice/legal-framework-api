require "rails_helper"

RSpec.describe ProceedingTypeScopePopulator do
  describe "records are properly populated" do
    describe "section 8 base" do
      let(:pt_ccms_code) { %w[SE003 SE004 SE007 SE008 SE013 SE014 SE015 SE016 SE095 SE097].sample }
      let(:client_involvement_type) { ClientInvolvementType::VALID_CLIENT_INVOLVEMENT_TYPES.sample }
      let(:client_involvement_type_not_a) { %w[D I W Z].sample }

      context "with service level 1 substantive" do
        let(:service_level) { 1 }
        let(:df_used) { false }
        let(:expected_scopes) { %w[CV027 CV079 CV117 CV118 FM004 FM007 FM015 FM019 FM059] }

        it "returns expected eligible scopes" do
          scope_records = ScopeLimitation.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_records.map(&:code)).to match_array(expected_scopes)
        end

        it "returns the expected default scope" do
          scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_record.code).to eq "FM059"
        end
      end

      context "with service level 1 delegated functions" do
        let(:service_level) { 1 }
        let(:df_used) { true }
        let(:expected_scopes) { %w[CV027 CV079 CV117 CV118 FM004 FM007 FM015 FM019] }

        it "returns the expected scopes" do
          scope_records = ScopeLimitation.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_records.map(&:code)).to match_array(expected_scopes)
        end

        context "with client involvement type A" do
          let(:client_involvement_type) { "A" }

          it "returns the expected default scope" do
            scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope_record.code).to eq "CV117"
          end
        end

        context "with client involvement types not A" do
          let(:client_involvement_type) { client_involvement_type_not_a }

          it "returns the expected default scope" do
            scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope_record.code).to eq "CV118"
          end
        end
      end

      context "with service level 3 substantive" do
        let(:service_level) { 3 }
        let(:df_used) { false }
        let(:expected_scopes) { %w[CV027 CV117 CV118 FM007 FM019 FM039 FM049] }

        it "returns expected eligible scopes" do
          scope_records = ScopeLimitation.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_records.map(&:code)).to match_array(expected_scopes)
        end

        it "returns the expected default scope" do
          scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_record.code).to eq "FM049"
        end
      end

      context "with service level 3 delegated functions" do
        let(:service_level) { 3 }
        let(:df_used) { true }
        let(:expected_scopes) { %w[CV027 CV117 CV118 FM007 FM019 FM039 FM049] }

        it "returns the expected scopes" do
          scope_records = ScopeLimitation.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_records.map(&:code)).to match_array(expected_scopes)
        end

        context "with client involvement type A" do
          let(:client_involvement_type) { "A" }

          it "returns the expected default scope" do
            scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope_record.code).to eq "CV117"
          end
        end

        context "with client involvement types not A" do
          let(:client_involvement_type) { client_involvement_type_not_a }

          it "returns the expected default scope" do
            scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope_record.code).to eq "CV118"
          end
        end
      end
    end

    describe "section 8 appeals" do
      let(:pt_ccms_code) { %w[SE003A SE004A SE007A SE008A SE013A SE014A SE015A SE016A SE095A SE097A SE101A].sample }
      let(:client_involvement_type) { ClientInvolvementType::VALID_CLIENT_INVOLVEMENT_TYPES.sample }
      let(:client_involvement_type_not_a) { %w[D I W Z].sample }

      context "with service level 3 substantive" do
        let(:service_level) { 3 }
        let(:df_used) { false }
        let(:expected_scopes) { %w[APL07 APL09 APL11 APL13 APL15 APL16 APL18 APL20 APL22 APL27 APL29 APL31 APL48 APL49 APL50 APL51 APL52 APL53 APL54 APL55 APL56 APL57 APL65 APL66 APL67 APL68 APL69 APL70 CV027 CV079 CV118] }

        it "returns expected eligible scopes" do
          scope_records = ScopeLimitation.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_records.map(&:code)).to match_array(expected_scopes)
        end

        it "returns the expected default scope" do
          scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_record.code).to eq "CV079"
        end
      end

      context "with service level 3 delegated functions" do
        let(:service_level) { 3 }
        let(:df_used) { true }
        let(:expected_scopes) { %w[APL07 APL09 APL11 APL13 APL15 APL16 APL18 APL20 APL22 APL27 APL29 APL31 APL48 APL49 APL50 APL51 APL52 APL53 APL54 APL55 APL56 APL57 APL65 APL66 APL67 APL68 APL69 APL70 CV027 CV079 CV118] }

        it "returns the expected scopes" do
          scope_records = ScopeLimitation.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_records.map(&:code)).to match_array(expected_scopes)
        end

        context "with client involvement type A" do
          let(:client_involvement_type) { "A" }

          it "returns the expected default scope" do
            scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope_record.code).to eq "CV118"
          end
        end

        context "with client involvement types not A" do
          let(:client_involvement_type) { client_involvement_type_not_a }

          it "returns the expected default scope" do
            scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope_record.code).to eq "CV118"
          end
        end
      end
    end

    describe "section 8 enforcements" do
      let(:pt_ccms_code) { %w[SE003E SE004E SE007E SE008E SE013E SE014E SE015E SE016E SE096E SE099E SE100E SE101E].sample }
      let(:client_involvement_type) { ClientInvolvementType::VALID_CLIENT_INVOLVEMENT_TYPES.sample }
      let(:client_involvement_type_not_a) { %w[D I W Z].sample }
      let(:expected_scopes) { %w[CV027 CV118 EF012 EF022 EF025 EF026 EF027 FM019 FM049 MC029] }

      context "with service level 3 substantive" do
        let(:service_level) { 3 }
        let(:df_used) { false }

        it "returns expected eligible scopes" do
          scope_records = ScopeLimitation.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_records.map(&:code)).to match_array(expected_scopes)
        end

        it "returns the expected default scope" do
          scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_record.code).to eq "FM019"
        end
      end

      context "with service level 3 delegated functions" do
        let(:service_level) { 3 }
        let(:df_used) { true }

        it "returns the expected scopes" do
          scope_records = ScopeLimitation.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_records.map(&:code)).to match_array(expected_scopes)
        end

        context "with client involvement type A" do
          let(:client_involvement_type) { "A" }

          it "returns the expected default scope" do
            scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope_record.code).to eq "FM019"
          end
        end

        context "with client involvement types not A" do
          let(:client_involvement_type) { client_involvement_type_not_a }

          it "returns the expected default scope" do
            scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope_record.code).to eq "FM019"
          end
        end
      end
    end

    describe "domestic abuse" do
      let(:pt_ccms_code) { %w[DA001 DA002 DA003 DA004 DA005 DA006 DA007 DA020].sample }
      let(:client_involvement_type) { ClientInvolvementType::VALID_CLIENT_INVOLVEMENT_TYPES.sample }
      let(:client_involvement_type_not_a) { %w[D I W Z].sample }

      context "with service level 3 substantive" do
        let(:service_level) { 3 }
        let(:df_used) { false }
        let(:expected_scopes) { %w[AA009 AA019 CV027 CV079 CV117 CV118 FM054] }

        it "returns expected eligible scopes" do
          scope_records = ScopeLimitation.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_records.map(&:code)).to match_array(expected_scopes)
        end

        it "returns the expected default scope" do
          scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_record.code).to eq "AA019"
        end
      end

      context "with service level 3 delegated functions" do
        let(:service_level) { 3 }
        let(:df_used) { true }
        let(:expected_scopes) { %w[AA009 CV027 CV079 CV117 CV118 FM054] }

        it "returns the expected scopes" do
          scope_records = ScopeLimitation.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope_records.map(&:code)).to match_array(expected_scopes)
        end

        context "with client involvement type A" do
          let(:client_involvement_type) { "A" }

          it "returns the expected default scope" do
            scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope_record.code).to eq "CV117"
          end
        end

        context "with client involvement types not A" do
          let(:client_involvement_type) { client_involvement_type_not_a }

          it "returns the expected default scope" do
            scope_record = ScopeLimitation.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope_record.code).to eq "CV118"
          end
        end
      end
    end
  end
end
