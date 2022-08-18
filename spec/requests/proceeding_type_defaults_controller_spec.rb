require "rails_helper"

RSpec.describe "ProceedingTypeDefaultsController", type: :request do
  describe "POST proceeding_type_defaults" do
    subject(:proceeding_type_defaults_post_request) { post proceeding_type_defaults_path, params: params.to_json, headers: }

    let(:request_id) { SecureRandom.uuid }
    let(:headers) { { "CONTENT_TYPE" => "application/json" } }
    let(:params) do
      {
        proceeding_type_ccms_code: "SE013",
        delegated_functions_used: false,
        client_involvement_type: "A",
        level_of_service_code: 1,
      }
    end

    context "when the request is successful" do
      it "returns success" do
        proceeding_type_defaults_post_request
        expect(response).to have_http_status(:success)
      end

      it "returns the expected response" do
        proceeding_type_defaults_post_request
        expect(JSON.parse(response.body)).to eq expected_successful_response
      end
    end

    context "when the request is unsuccessful" do
      let(:params) do
        {
          proceeding_type_ccms_code: "XX123",
          delegated_functions_used: false,
          client_involvement_type: "A",
          level_of_service_code: 1,
        }
      end

      it "returns bad request" do
        proceeding_type_defaults_post_request
        expect(response.status).to eq 400
      end

      it "returns expected error response" do
        proceeding_type_defaults_post_request
        expect(parsed_response[:success]).to be false
        expect(parsed_response[:errors]).to match [/The property '#\/proceeding_type_ccms_code' value "XX123" did not match one of the following values: .* in schema file/]
      end
    end

    def expected_successful_response
      {
        success: true,
        requested_params: {
          proceeding_type_ccms_code: "SE013",
          delegated_functions_used: false,
          client_involvement_type: "A",
          level_of_service_code: 1,
        },
        default_level_of_service: {
          level: 1,
          name: "Family Help (Higher)",
          stage: 1,
        },
        default_scope: {
          code: "FM059",
          meaning: "FHH Children",
          description: "Limited to Family Help (Higher) and to all steps necessary to negotiate and conclude a settlement. To include the issue of proceedings and representation in those proceedings save in relation to or at a contested final hearing.",
          additional_params: [],
        },
      }.as_json
    end
  end
end
