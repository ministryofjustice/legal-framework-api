require "rails_helper"

RSpec.describe OrganisationTypeService do
  describe ".call" do
    subject(:organisation_type_service_response) { described_class.call(ccms_code) }

    context "with a valid organisation type" do
      let(:ccms_code) { %w[CO] }

      it "returns valid response with expected tasks" do
        expect(organisation_type_service_response).to eq expected_co_response
      end
    end

    context "with a non-existent ccms_code" do
      let(:ccms_code) { "XX" }

      it "returns error" do
        response = organisation_type_service_response
        expect(response[:success]).to be false
        expect(response[:message]).to match("No such organisation type: 'XX'")
      end
    end

    context "with no ccms_code specified" do
      let(:ccms_code) { nil }

      it "returns error" do
        response = organisation_type_service_response
        expect(response[:success]).to be false
        expect(response[:message]).to eq "Must specify an organisation type"
      end
    end
  end

  def expected_co_response
    {
      success: true,
      organisation_type: {
        "ccms_code" => "CO",
        "description" => "Court",
      },
    }
  end
end
