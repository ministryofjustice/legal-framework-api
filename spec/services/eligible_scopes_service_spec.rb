require "rails_helper"

RSpec.describe EligibleScopesService do
  let(:s8_base_pt_codes) { %w[SE003 SE004 SE007 SE008 SE013 SE014 SE015 SE016 SE095 SE097] }
  let(:s8_appeals_pt_codes) { %w[SE003A SE004A SE007A SE008A SE013A SE014A SE015A SE016A SE095A SE097A SE101A] }
  let(:s8_enforcements_pt_codes) { %w[SE003E SE004E SE007E SE008E SE013E SE014E SE015E SE016E SE096E SE100E SE101E] }
  let(:domestic_abuse_pt_codes) { %w[DA001 DA002 DA003 DA004 DA005 DA006 DA007 DA020] }

  describe ".default_service_level" do
    context "with section_8_base" do
      let(:pt_ccms_code) { %w[SE003 SE004 SE007 SE008 SE013 SE014 SE015 SE016 SE095 SE097].sample }

      it "returns service level 1" do
        expect(described_class.default_service_level(pt_ccms_code)).to eq 1
      end
    end

    context "with any other scheme" do
      let(:pt_ccms_code) { (s8_appeals_pt_codes + s8_enforcements_pt_codes + domestic_abuse_pt_codes).sample }

      it "returns service level 3" do
        expect(described_class.default_service_level(pt_ccms_code)).to eq 3
      end
    end

    context "when sent an invalid proceeding code" do
      let(:pt_ccms_code) { "bad_code" }

      it { expect { described_class.default_service_level(pt_ccms_code) }.to raise_error RuntimeError, "No such proceeding type 'bad_code'" }
    end

    context "when proceeding code returns an invalid scheme" do
      # I think this should highlight badly configured config files
      before do
        allow(described_class.config).to receive(:[]).and_call_original
        allow(described_class.config).to receive(:[]).with(:proceeding_types).and_return(fake_hash)
      end

      let(:fake_hash) { { "PBM01" => :bad_scheme_name } }
      let(:pt_ccms_code) { "PBM01" }

      it { expect { described_class.default_service_level(pt_ccms_code) }.to raise_error RuntimeError, "No such scheme 'bad_scheme_name'" }
    end
  end

  describe ".eligible_scopes and .default_scope methods" do
    describe "when called with an invalid client involvement type" do
      it "raises the expected error" do
        expect { described_class.eligible_scopes("PBM01", "R", 1, false) }.to raise_error RuntimeError, "Invalid Client Involvement Type 'R'"
      end
    end

    context "when proceeding code returns an invalid service level" do
      # I think this should highlight badly configured config files
      it { expect { described_class.eligible_scopes("PBM01", "A", 77, true) }.to raise_error RuntimeError, "No such service level '77'" }
    end

    describe "section 8 base" do
      let(:pt_ccms_code) { s8_base_pt_codes.sample }
      let(:client_involvement_type) { %w[A D I W Z].sample }
      let(:client_involvement_type_not_a) { %w[D I W Z].sample }

      context "with service level 1 substantive" do
        let(:service_level) { 1 }
        let(:df_used) { false }
        let(:expected_scopes) { %w[CV027 CV079 CV117 CV118 FM004 FM007 FM015 FM019 FM059] }

        it "returns expected eligible scopes" do
          scopes = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scopes).to match_array(expected_scopes)
        end

        it "returns the expected default scope" do
          scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to eq "FM059"
        end
      end

      context "with service level 1 delegated functions" do
        let(:service_level) { 1 }
        let(:df_used) { true }
        let(:expected_scopes) { %w[CV027 CV079 CV117 CV118 FM004 FM007 FM015 FM019] }

        it "returns the expected scopes" do
          scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to match_array(expected_scopes)
        end

        context "with client involvement type A" do
          let(:client_involvement_type) { "A" }

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV117"
          end
        end

        context "with client involvement types not A" do
          let(:client_involvement_type) { client_involvement_type_not_a }

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV118"
          end
        end
      end

      context "with service level 3 substantive" do
        let(:service_level) { 3 }
        let(:df_used) { false }
        let(:expected_scopes) { %w[CV027 CV117 CV118 FM007 FM019 FM039 FM049] }

        it "returns expected eligible scopes" do
          scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to match_array(expected_scopes)
        end

        it "returns the expected default scope" do
          scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to eq "FM049"
        end
      end

      context "with service level 3 delegated functions" do
        let(:service_level) { 3 }
        let(:df_used) { true }
        let(:expected_scopes) { %w[CV027 CV117 CV118 FM007 FM019 FM039 FM049] }

        it "returns the expected scopes" do
          scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to match_array(expected_scopes)
        end

        context "with client involvement type A" do
          let(:client_involvement_type) { "A" }

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV117"
          end
        end

        context "with client involvement types not A" do
          let(:client_involvement_type) { client_involvement_type_not_a }

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV118"
          end
        end
      end
    end

    describe "section 8 appeals" do
      let(:pt_ccms_code) { s8_appeals_pt_codes.sample }
      let(:client_involvement_type) { %w[A D I W Z].sample }
      let(:client_involvement_type_not_a) { %w[D I W Z].sample }

      context "with service level 3 substantive" do
        let(:service_level) { 3 }
        let(:df_used) { false }
        let(:expected_scopes) { %w[APL07 APL09 APL11 APL13 APL15 APL16 APL18 APL20 APL22 APL27 APL29 APL31 APL48 APL49 APL50 APL51 APL52 APL53 APL54 APL55 APL56 APL57 APL65 APL66 APL67 APL68 APL69 APL70 CV027 CV079 CV118] }

        it "returns expected eligible scopes" do
          scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to match_array(expected_scopes)
        end

        it "returns the expected default scope" do
          scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to eq "CV079"
        end
      end

      context "with service level 3 delegated functions" do
        let(:service_level) { 3 }
        let(:df_used) { true }
        let(:expected_scopes) { %w[APL07 APL09 APL11 APL13 APL15 APL16 APL18 APL20 APL22 APL27 APL29 APL31 APL48 APL49 APL50 APL51 APL52 APL53 APL54 APL55 APL56 APL57 APL65 APL66 APL67 APL68 APL69 APL70 CV027 CV079 CV118] }

        it "returns the expected scopes" do
          scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to match_array(expected_scopes)
        end

        context "with client involvement type A" do
          let(:client_involvement_type) { "A" }

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV118"
          end
        end

        context "with client involvement types not A" do
          let(:client_involvement_type) { client_involvement_type_not_a }

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV118"
          end
        end
      end
    end

    describe "section 8 enforcements" do
      let(:pt_ccms_code) { s8_enforcements_pt_codes.sample }
      let(:client_involvement_type) { %w[A D I W Z].sample }
      let(:client_involvement_type_not_a) { %w[D I W Z].sample }
      let(:expected_scopes) { %w[CV027 CV118 EF012 EF022 EF025 EF026 EF027 FM019 FM049 MC029] }

      context "with service level 3 substantive" do
        let(:service_level) { 3 }
        let(:df_used) { false }

        it "returns expected eligible scopes" do
          scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to match_array(expected_scopes)
        end

        it "returns the expected default scope" do
          scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to eq "FM019"
        end
      end

      context "with service level 3 delegated functions" do
        let(:service_level) { 3 }
        let(:df_used) { true }

        it "returns the expected scopes" do
          scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to match_array(expected_scopes)
        end

        context "with client involvement type A" do
          let(:client_involvement_type) { "A" }

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "FM019"
          end
        end

        context "with client involvement types not A" do
          let(:client_involvement_type) { client_involvement_type_not_a }

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "FM019"
          end
        end
      end
    end

    describe "domestic abuse" do
      let(:pt_ccms_code) { domestic_abuse_pt_codes.sample }
      let(:client_involvement_type) { %w[A D I W Z].sample }
      let(:client_involvement_type_not_a) { %w[D I W Z].sample }

      context "with service level 3 substantive" do
        let(:service_level) { 3 }
        let(:df_used) { false }
        let(:expected_scopes) { %w[AA009 AA019 CV027 CV079 CV117 CV118 FM054] }

        it "returns expected eligible scopes" do
          scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to match_array(expected_scopes)
        end

        it "returns the expected default scope" do
          scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to eq "AA019"
        end
      end

      context "with service level 3 delegated functions" do
        let(:service_level) { 3 }
        let(:df_used) { true }
        let(:expected_scopes) { %w[AA009 CV027 CV079 CV117 CV118 FM054] }

        it "returns the expected scopes" do
          scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
          expect(scope).to match_array(expected_scopes)
        end

        context "with client involvement type A" do
          let(:client_involvement_type) { "A" }

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV117"
          end
        end

        context "with client involvement types not A" do
          let(:client_involvement_type) { client_involvement_type_not_a }

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV118"
          end
        end
      end
    end

    describe "public law family" do
      let(:service_level) { 3 }

      context "when the proceeding is in the child_applicant_option group" do
        let(:pt_ccms_code) { "PBM01" }
        let(:expected_scopes) { %w[FM019 CV118 CV079 FM007 FM062 CV027] }

        context "and has not used delegated functions" do
          let(:df_used) { false }

          context "and the client is a child subject" do
            let(:client_involvement_type) { "W" }

            it "returns the expected scopes" do
              scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
              expect(scope).to match_array(expected_scopes)
            end

            it "returns the expected default scope" do
              scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
              expect(scope).to eq "FM062"
            end
          end

          context "and the client is not a child subject" do
            let(:client_involvement_type) { "D" }

            it "returns the expected scopes" do
              scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
              expect(scope).to match_array(expected_scopes)
            end

            it "returns the expected default scope" do
              scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
              expect(scope).to eq "FM019"
            end
          end
        end

        context "and has used delegated functions" do
          let(:df_used) { true }

          context "and the client is a child subject" do
            let(:client_involvement_type) { "W" }

            it "returns the expected scopes" do
              scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
              expect(scope).to match_array(expected_scopes)
            end

            it "returns the expected default scope" do
              scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
              expect(scope).to eq "CV118"
            end
          end

          context "and the client is not a child subject" do
            let(:client_involvement_type) { "D" }

            it "returns the expected scopes" do
              scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
              expect(scope).to match_array(expected_scopes)
            end

            it "returns the expected default scope" do
              scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
              expect(scope).to eq "CV118"
            end
          end
        end
      end

      context "when the proceeding is in the placement order group" do
        let(:pt_ccms_code) { "PBM40" }
        let(:expected_scopes) { %w[FM019 CV118 FM062 CV027 EF025 EF026 EF022] }

        context "and has not used delegated functions" do
          let(:df_used) { false }
          let(:client_involvement_type) { "A" }

          it "returns the expected scopes" do
            scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to match_array(expected_scopes)
          end

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "FM062"
          end
        end

        context "and has used delegated functions" do
          let(:df_used) { true }
          let(:client_involvement_type) { "A" }

          it "returns the expected scopes" do
            scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to match_array(expected_scopes)
          end

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV118"
          end
        end
      end

      context "when the proceeding is in the appeals base group" do
        let(:pt_ccms_code) { "PBM01A" }
        let(:client_involvement_type) { "A" }
        let(:expected_scopes) { %w[APL48 APL09 APL49 APL11 APL50 APL13 APL51 APL15 APL16 APL52 APL18 APL53 APL20 APL54 APL22 APL65 APL66 APL67 APL68 APL69 APL70 CV118 CV079 CV027] }

        context "and has not used delegated functions" do
          let(:df_used) { false }

          it "returns the expected scopes" do
            scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to match_array(expected_scopes)
          end

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV079"
          end
        end

        context "and has used delegated functions" do
          let(:df_used) { true }

          it "returns the expected scopes" do
            scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to match_array(expected_scopes)
          end

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV118"
          end
        end
      end

      context "when the proceeding is in the enforcement base group" do
        let(:pt_ccms_code) { "PBM02E" }
        let(:client_involvement_type) { "A" }
        let(:expected_scopes) { %w[CV118 EF025 EF022 CV027 FM019] }

        context "and has not used delegated functions" do
          let(:df_used) { false }

          it "returns the expected scopes" do
            scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to match_array(expected_scopes)
          end

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "FM019"
          end
        end

        context "and has used delegated functions" do
          let(:df_used) { true }

          it "returns the expected scopes" do
            scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to match_array(expected_scopes)
          end

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "EF025"
          end
        end
      end

      context "when the proceeding is in the enforcement orders group" do
        let(:pt_ccms_code) { "PBM40E" }
        let(:client_involvement_type) { "A" }
        let(:expected_scopes) { %w[CV118 FM062 EF025 EF026 EF022 CV027 FM019] }

        context "and has not used delegated functions" do
          let(:df_used) { false }

          it "returns the expected scopes" do
            scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to match_array(expected_scopes)
          end

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "CV118"
          end
        end

        context "and has used delegated functions" do
          let(:df_used) { true }

          it "returns the expected scopes" do
            scope = described_class.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to match_array(expected_scopes)
          end

          it "returns the expected default scope" do
            scope = described_class.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)
            expect(scope).to eq "FM062"
          end
        end
      end
    end
  end
end
