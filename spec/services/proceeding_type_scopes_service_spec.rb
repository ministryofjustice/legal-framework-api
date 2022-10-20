require "rails_helper"

RSpec.describe ProceedingTypeScopesService do
  subject(:proceeding_type_scopes_response) { described_class.call(proceeding_type_scopes_params:) }

  let(:proceeding_type_scopes_params) do
    {
      proceeding_type_ccms_code:,
      delegated_functions_used:,
      client_involvement_type:,
      level_of_service_code:,
    }.to_json
  end
  let(:proceeding_type_ccms_code) { "SE003" }
  let(:delegated_functions_used) { false }
  let(:client_involvement_type) { "D" }
  let(:level_of_service_code) { 1 }

  context "when the request is successful" do
    it "returns valid response with expected defaults" do
      expect(proceeding_type_scopes_response).to eq expected_successful_response
    end
  end

  context "when the request is unsuccessful" do
    context "with a non_existent client_involvement_type" do
      let(:level_of_service_code) { 7 }

      it "returns error" do
        response = proceeding_type_scopes_response
        expect(response[:success]).to be false
        expect(response[:errors]).to match [/The property '#\/level_of_service_code' value 7 did not match one of the following values: .* in schema file/]
      end
    end
  end

  def expected_successful_response
    {
      success: true,
      requested_params: {
        proceeding_type_ccms_code: "SE003",
        delegated_functions_used: false,
        client_involvement_type: "D",
        level_of_service_code: 1,
      },
      level_of_service: {
        level: 1,
        name: "Family Help (Higher)",
        stage: 1,
        scope_limitations: [
          {
            code: "FM007",
            meaning: "Blood Tests or DNA Tests",
            description: "Limited to all steps up to and including the obtaining of blood tests or DNA tests and thereafter a solicitor's report.",
            additional_params: [],
          },
          {
            code: "FM004",
            meaning: "CAFCASS report",
            description: "Limited to all steps up to and including the Children and Family Reporter's Report and thereafter a solicitor's report.",
            additional_params: [],
          },
          {
            code: "CV079",
            meaning: "Counsel's Opinion",
            description: "Limited to obtaining external Counsel's Opinion or the opinion of an external solicitor with higher court advocacy rights on the information already available.",
            additional_params: [],
          },
          {
            code: "FM019",
            meaning: "Exchange of Evidence",
            description: "Limited to all steps up to and including the exchange of evidence (including any welfare officer's/guardian ad litem's report) and directions appointments but not including a final contested hearing and thereafter to a solicitors report (or if so advised a Counsel's opinion) on the issues and prospects of success.",
            additional_params: [],
          },
          {
            code: "FM059",
            meaning: "FHH Children",
            description: "Limited to Family Help (Higher) and to all steps necessary to negotiate and conclude a settlement. To include the issue of proceedings and representation in those proceedings save in relation to or at a contested final hearing.",
            additional_params: [],
          },
          {
            code: "CV118",
            meaning: "Hearing",
            description: "Limited to all steps up to and including the hearing on [see additional limitation notes]",
            additional_params: [
              {
                name: "hearing_date",
                type: "date",
                mandatory: true,
              },
            ],
          },
          {
            code: "CV027",
            meaning: "Hearing/Adjournment",
            description: "Limited to all steps (including any adjournment thereof) up to and including the hearing on",
            additional_params: [
              {
                name: "hearing_date",
                type: "date",
                mandatory: true,
              },
            ],
          },
          {
            code: "CV117",
            meaning: "Interim order inc. return date",
            description: "Limited to all steps necessary to apply for an interim order; where application is made without notice to include representation on the return date.",
            additional_params: [],
          },
          {
            code: "FM015",
            meaning: "Section 37 Report",
            description: "Limited to a section 37 report only.",
            additional_params: [],
          },
        ],
      },
    }
  end
end
