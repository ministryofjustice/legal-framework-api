require "swagger_helper"

RSpec.describe "proceeding_types", type: :request do
  path "/proceeding_types/{ccms_code}" do
    get("Show details for a single proceeding type") do
      let(:ccms_code) { "SE003" }
      parameter name: "ccms_code",
                in: :path,
                type: :string,
                example: "SE003",
                description: "CCMS code, e.g. DA001 or SE013"

      description "Return all details for specified proceeding type"
      tags "Proceeding types"

      produces "application/json"

      response(200, "successful") do
        expected_response =
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
        example "application/json",
                :success,
                expected_response,
                "Successful request",
                "Return all details for specified proceeding type"
        run_test! do |response|
          expect(response).to have_http_status(:success)
          expect(response.body).to eq expected_response.to_json
        end
      end

      response(400, "Bad request") do
        let(:ccms_code) { "AZ123" }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json": {
              examples: {
                bad_request: {
                  value: JSON.parse(response.body, symbolize_names: true),
                  summary: "Bad request",
                  description: "When a non-existent ccms_code is sent, an error is generated from the json schema and returned",
                },
              },
            },
          }
        end

        run_test! do |response|
          expect(response).to have_http_status(:bad_request)
          expect(parsed_response[:error_class]).to eq "ActiveRecord::RecordNotFound"
          expect(parsed_response[:message]).to match "No such proceeding type: 'AZ123'"
        end
      end
    end
  end
end
