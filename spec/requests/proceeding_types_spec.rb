# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ProceedingTypesController", type: :request do
  describe "GET /proceeding_types/{code}" do
    subject(:proceeding_type_get_request) { get proceeding_type_path(ccms_code), headers: }

    let(:ccms_code) { "SE003" }
    let(:headers) { { "CONTENT_TYPE" => "application/json" } }

    context "when the request is successful" do
      it "returns success" do
        proceeding_type_get_request
        expect(response).to have_http_status(:success)
      end

      it "returns the response supplied by the ProceedingTypesService" do
        proceeding_type_get_request
        expect(response.body).to eq expected_successful_response.to_json
      end
    end

    def expected_successful_response
      {
        success: true,
        ccms_code: "SE003",
        meaning: "Prohibited steps order",
        ccms_category_law_code: "MAT",
        ccms_matter_code: "KSEC8",
        name: "prohibited_steps_order_s8",
        description: "to be represented on an application for a prohibited steps order.",
        full_s8_only: false,
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

    context "when the request is unsuccessful" do
      let(:ccms_code) { "AZ123" }

      it "returns bad request" do
        proceeding_type_get_request
        expect(response.status).to eq 400
      end

      it "returns expected error response" do
        proceeding_type_get_request
        expect(parsed_response[:success]).to be false
        expect(parsed_response[:error_class]).to eq "ActiveRecord::RecordNotFound"
        expect(parsed_response[:message]).to match "No such proceeding type: 'AZ123'"
        expect(parsed_response[:backtrace]).to be_instance_of(Array)
      end
    end
  end
end
