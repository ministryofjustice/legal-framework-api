require "rails_helper"

RSpec.describe ClientInvolvementTypeService do
  describe ".call" do
    subject(:client_involvement_type_service_response) { described_class.call(proceeding_type_ccms_code) }

    context "with a valid proceeding type" do
      let(:response) { client_involvement_type_service_response }

      context "and is an sca_core proceeding" do
        let(:proceeding_type_ccms_code) { "PB003" }

        it "returns valid response with expected tasks" do
          expect(response[:success]).to be true
          expect(response[:client_involvement_type]).to match_json_expression(expected_sca_core_response)
        end
      end

      context "and is an sca_related proceeding" do
        let(:proceeding_type_ccms_code) { "PB007" }

        it "returns valid response with expected tasks" do
          expect(response[:success]).to be true
          expect(response[:client_involvement_type]).to match_json_expression(expected_sca_related_response)
        end
      end

      context "and is not an sca proceeding" do
        let(:proceeding_type_ccms_code) { "DA001" }

        it "returns valid response with expected tasks" do
          expect(response[:success]).to be true
          expect(response[:client_involvement_type]).to match_json_expression(expected_default_response)
        end
      end
    end

    context "with a non-existent ccms_code" do
      let(:proceeding_type_ccms_code) { "XX" }

      xit "returns error" do
        response = client_involvement_type_service_response
        expect(response[:success]).to be false
        expect(response[:message]).to match("No such client involvement type: 'XX'")
      end
    end

    context "with no ccms_code specified" do
      let(:proceeding_type_ccms_code) { nil }

      xit "returns error" do
        response = client_involvement_type_service_response
        expect(response[:success]).to be false
        expect(response[:message]).to eq "Must specify a client involvement type"
      end
    end
  end

  def expected_sca_core_response
    [
      { "ccms_code" => "D", "description" => "Respondent" },
      { "ccms_code" => "W", "description" => "Subject of proceedings (child)" },
    ]
  end

  def expected_sca_related_response
    [
      { "ccms_code" => "A", "description" => "Applicant/claimant/petitioner" },
      { "ccms_code" => "D", "description" => "Respondent" },
      { "ccms_code" => "W", "description" => "Subject of proceedings (child)" },
    ]
  end

  def expected_default_response
    [
      { "ccms_code" => "A", "description" => "Applicant/claimant/petitioner" },
      { "ccms_code" => "D", "description" => "Defendant/respondent" },
      { "ccms_code" => "W", "description" => "Subject of proceedings (child)" },
      { "ccms_code" => "I", "description" => "Intervenor" },
      { "ccms_code" => "Z", "description" => "Joined party" },
    ]
  end
end
