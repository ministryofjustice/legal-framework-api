require "rails_helper"

RSpec.describe "ClientInvolvementTypesController", type: :request do
  before { seed_live_data }

  let(:headers) { { "CONTENT_TYPE" => "application/json" } }

  describe "GET client_involvement_types" do
    subject(:get_request) { get client_involvement_types_path, headers: }

    before { get_request }

    it "returns a successful response with all client_involvement_types" do
      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eql("application/json")
      expect(JSON.parse(response.body).count).to eq 5
    end
  end
end