require "rails_helper"

RSpec.describe ProceedingTypeService do
  describe ".call" do
    subject(:proceeding_type_service_response) { described_class.call(ccms_code) }

    context "with a valid proceeding that has just one service level" do
      let(:ccms_code) { %w[DA003] }

      it "returns valid response with expected tasks" do
        expect(proceeding_type_service_response).to eq expected_da003_response
      end
    end

    context "with a valid proceeding that has multiple service levels" do
      let(:ccms_code) { %w[SE003] }

      it "returns valid response with expected tasks" do
        expect(proceeding_type_service_response).to eq expected_se003_response
      end
    end

    context "with a non-existent ccms_code" do
      let(:ccms_code) { "XX001" }

      it "returns error" do
        response = proceeding_type_service_response
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq "ActiveRecord::RecordNotFound"
        expect(response[:message]).to match("No such proceeding type: 'XX001'")
        expect(response[:backtrace]).to be_instance_of(Array)
      end
    end

    context "with no ccms_code specified" do
      let(:ccms_code) { nil }

      it "returns error" do
        response = proceeding_type_service_response
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq "ProceedingTypeService::ProceedingTypeServiceError"
        expect(response[:message]).to eq "Must specify a proceeding type"
        expect(response[:backtrace]).to be_instance_of(Array)
      end
    end
  end

  def expected_da003_response
    {
      success: true,
      ccms_code: "DA003",
      name: "harassment_injunction",
      meaning: "Harassment - injunction",
      ccms_category_law_code: "MAT",
      ccms_matter_code: "MINJN",
      description: "to be represented in an action for an injunction under"\
                   " section 3 Protection from Harassment Act 1997.",
      ccms_category_law: "Family",
      ccms_matter: "Domestic abuse",
      cost_limitations: {
        substantive: {
          start_date: "1970-01-01",
          value: "25000.0",
        },
        delegated_functions: {
          start_date: "2021-09-13",
          value: "2250.0",
        },
      },
      default_scope_limitations: {
        substantive: {
          code: "AA019",
          meaning: "Injunction FLA-to final hearing",
          description: "As to proceedings under Part IV Family Law Act 1996"\
                       " limited to all steps up to and including obtaining and"\
                       " serving a final order and in the event of breach leading"\
                       " to the exercise of a power of arrest to representation on"\
                       " the consideration of the breach by the court (but excluding"\
                       " applying for a warrant of arrest, if not attached, and"\
                       " representation in contempt proceedings).",
        },
        delegated_functions: {
          code: "CV117",
          meaning: "Interim order inc. return date",
          description: "Limited to all steps necessary to apply for an interim order;"\
                       " where application is made without notice to include representation on the return date.",
        },
      },
      service_levels: [
        {
          level: 3,
          name: "Full Representation",
          stage: 8,
          proceeding_default: true,
        },
      ],
    }
  end

  def expected_se003_response
    {
      success: true,
      ccms_code: "SE003",
      meaning: "Prohibited steps order",
      ccms_category_law_code: "MAT",
      ccms_matter_code: "KSEC8",
      name: "prohibited_steps_order_s8",
      description: "to be represented on an application for a prohibited steps order.",
      ccms_category_law: "Family",
      ccms_matter: "Children - section 8",
      cost_limitations: {
        substantive: {
          start_date: "1970-01-01",
          value: "25000.0",
        },
        delegated_functions: {
          start_date: "2021-09-13",
          value: "2250.0",
        },
      },
      default_scope_limitations: {
        substantive: {
          code: "FM059",
          meaning: "FHH Children",
          description: "Limited to Family Help (Higher) and to all steps necessary to negotiate and conclude a settlement."\
                       " To include the issue of proceedings and representation in those proceedings save in relation to or at a contested final hearing.",
        },
        delegated_functions: {
          code: "CV117",
          meaning: "Interim order inc. return date",
          description: "Limited to all steps necessary to apply for an interim order;"\
                       " where application is made without notice to include representation on the return date.",
        },
      },
      service_levels: [
        {
          level: 1,
          name: "Family Help (Higher)",
          stage: 1,
          proceeding_default: true,
        },
        {
          level: 3,
          name: "Full Representation",
          stage: 8,
          proceeding_default: false,
        },
      ],
    }
  end
end
