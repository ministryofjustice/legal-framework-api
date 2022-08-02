require "rails_helper"

RSpec.describe "ProceedingTypes/SearchController", type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json" } }

  describe "GET proceeding_types/all" do
    subject(:proceeding_types_get_request) { get proceeding_types_all_path, headers: }

    before { proceeding_types_get_request }

    it "returns a successful response with all proceedingtypes" do
      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eql("application/json")
      expect(JSON.parse(response.body).count).to eq 12
    end
  end

  describe "POST proceeding_types/searches" do
    subject(:proceeding_types_post_request) { post proceeding_types_searches_path, params: params.to_json, headers: }

    let(:params) do
      {
        search_term:,
      }
    end
    let(:search_term) { "Occupation" }

    context "when the params are valid" do
      before { proceeding_types_post_request }

      let(:expected_result) do
        {
          success: true,
          data: [
            {
              meaning: "Occupation order",
              ccms_code: "DA005",
              description: "to be represented on an application for an occupation order.",
              full_s8_only: false,
              ccms_category_law: "Family",
              ccms_matter: "Domestic abuse",
            },
          ],
        }
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
        expect(response.media_type).to eql("application/json")
        expect(JSON.parse(response.body)).to match_json_expression(expected_result)
      end
    end

    context "when no matches found" do
      before { proceeding_types_post_request }

      let(:search_term) { "nonexistant" }
      let(:expected_result) do
        {
          success: false,
          data: [],
        }
      end

      it "returns an unsuccessful response" do
        expect(response).to have_http_status(:ok)
        expect(response.media_type).to eql("application/json")
        expect(JSON.parse(response.body)).to match_json_expression(expected_result)
      end
    end

    context "when an error occurs" do
      before do
        allow(ProceedingTypeFullTextSearch).to receive(:call).and_raise(StandardError.new("Unexpected error in full text search"))
        proceeding_types_post_request
      end

      let(:expected_result) do
        {
          success: false,
          error: "StandardError",
          message: "Unexpected error in full text search",
        }
      end

      it "returns an unsuccessful response" do
        expect(response).to have_http_status(:bad_request)
        expect(response.media_type).to eql("application/json")
        expect(JSON.parse(response.body)).to match_json_expression(expected_result)
      end
    end

    context "when returning multiple results" do
      before { proceeding_types_post_request }

      let(:search_term) { "injunction" }

      it "returns a successful response with three results" do
        expect(response).to have_http_status(:ok)
        expect(response.media_type).to eql("application/json")
        expect(JSON.parse(response.body).symbolize_keys[:data].count).to eq 3
      end

      context "and one of the codes is excluded" do
        let(:params) do
          {
            search_term: "injunction",
            excluded_codes: "DA001",
          }
        end

        it "returns a successful response with two results" do
          expect(response).to have_http_status(:ok)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body).symbolize_keys[:data].count).to eq 2
        end
      end
    end

    context "when excluded_codes matches" do
      describe "the single match" do
        before { proceeding_types_post_request }

        let(:params) do
          {
            search_term:,
            excluded_codes: "DA005",
          }
        end
        let(:expected_result) do
          {
            success: false,
            data: [],
          }
        end

        it "returns an unsuccessful response" do
          expect(response).to have_http_status(:ok)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body)).to match_json_expression(expected_result)
        end
      end
    end
  end
end
