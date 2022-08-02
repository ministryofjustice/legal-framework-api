require "rails_helper"

RSpec.describe ProceedingTypeDefaultsService do
  subject(:proceeding_type_default_response) { described_class.call(proceeding_type_ccms_code:, delegated_functions_used:, client_involvement_type:, level_of_service_code:) }

  let(:proceeding_type_ccms_code) { "SE003" }
  let(:delegated_functions_used) { true }
  let(:client_involvement_type) { "D" }
  let(:level_of_service_code) { 1 }

  context "when the request is successful" do
    it "returns valid response with expected defaults" do
      expect(proceeding_type_default_response).to eq expected_successful_response
    end
  end

  context "when the request is unsuccessful" do
    context "with a non_existent client_involvement_type" do
      let(:client_involvement_type) { "X" }

      it "returns error" do
        response = proceeding_type_default_response
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq "ActiveRecord::RecordNotFound"
        expect(response[:message]).to match(/Couldn't find ProceedingTypeScope/)
        expect(response[:backtrace]).to be_instance_of(Array)
      end
    end
  end

  def expected_successful_response
    {
      success: true,
      requested_params: {
        proceeding_type_ccms_code: "SE003",
        delegated_functions_used: true,
        client_involvement_type: "D",
        level_of_service_code: 1,
      },
      default_level_of_service: {
        level: 1,
        name: "Family Help (Higher)",
        stage: 1,
      },
      default_scope: {
        code: "CV118",
        meaning: "Hearing",
        description: "Limited to all steps up to and including the hearing on [see additional limitation notes]",
      },
    }
  end
end
