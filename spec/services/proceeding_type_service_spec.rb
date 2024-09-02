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
      end
    end

    context "with no ccms_code specified" do
      let(:ccms_code) { nil }

      it "returns error" do
        response = proceeding_type_service_response
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq "ProceedingTypeService::ProceedingTypeServiceError"
        expect(response[:message]).to eq "Must specify a proceeding type"
      end
    end

    context "with a valid new s8 proceeding type" do
      let(:ccms_code) { %w[SE003A] }

      it "returns valid response without scope limitations or service levels" do
        expect(proceeding_type_service_response).to eq expected_se003a_response
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
      description: "to be represented in an action for an injunction under " \
                   "section 3 Protection from Harassment Act 1997.",
      full_s8_only: false,
      sca_core: false,
      sca_related: false,
      ccms_category_law: "family",
      ccms_matter: "domestic abuse (DA)",
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
          description: "As to proceedings under Part IV Family Law Act 1996 " \
                       "limited to all steps up to and including obtaining and " \
                       "serving a final order and in the event of breach leading " \
                       "to the exercise of a power of arrest to representation on " \
                       "the consideration of the breach by the court (but excluding " \
                       "applying for a warrant of arrest, if not attached, and " \
                       "representation in contempt proceedings).",
        },
        delegated_functions: {
          code: "CV117",
          meaning: "Interim order inc. return date",
          description: "Limited to all steps necessary to apply for an interim order; " \
                       "where application is made without notice to include representation on the return date.",
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
      full_s8_only: false,
      sca_core: false,
      sca_related: false,
      ccms_category_law: "family",
      ccms_matter: "section 8 children (S8)",
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
          description: "Limited to Family Help (Higher) and to all steps necessary to negotiate and conclude a settlement. " \
                       "To include the issue of proceedings and representation in those proceedings save in relation to or at a contested final hearing.",
        },
        delegated_functions: {
          code: "CV117",
          meaning: "Interim order inc. return date",
          description: "Limited to all steps necessary to apply for an interim order; " \
                       "where application is made without notice to include representation on the return date.",
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

  def expected_se003a_response
    {
      success: true,
      ccms_code: "SE003A",
      meaning: "Prohibited steps order - appeal",
      ccms_category_law_code: "MAT",
      ccms_matter_code: "KSEC8",
      name: "prohibited_steps_order_appeal_s8",
      description: "to be represented on an application for a prohibited steps order.  Appeals only.",
      full_s8_only: true,
      sca_core: false,
      sca_related: false,
      ccms_category_law: "family",
      ccms_matter: "section 8 children (S8)",
      cost_limitations: {
        substantive: {
          start_date: "1970-01-01",
          value: "5000.0",
        },
        delegated_functions: {
          start_date: "2021-09-13",
          value: "2250.0",
        },
      },
      default_scope_limitations: {
        substantive: {
          code: "CV079",
          meaning: "Counsel's Opinion",
          description: "Limited to obtaining external Counsel's Opinion or the opinion of an external solicitor with higher court advocacy rights on the information already available.",
        },
        delegated_functions: {
          code: "CV118",
          meaning: "Hearing",
          description: "Limited to all steps up to and including the hearing on [see additional limitation notes]",
        },
      },
      service_levels: [
        {
          level: 3,
          name: "Full Representation",
          proceeding_default: true,
          stage: 8,
        },
      ],
    }
  end
end
