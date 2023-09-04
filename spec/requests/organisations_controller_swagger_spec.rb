require "swagger_helper"

RSpec.describe "organisations" do
  path "/organisation_searches/all" do
    get("Get summary of all organisations") do
      description "Returns an array of all organisations with summary data."

      tags "Organisations"
      produces "application/json"

      response(200, "successful") do
        after do |example|
          example.metadata[:response][:content] = {
            "application/json": {
              examples: {
                success: {
                  value: JSON.parse(response.body, symbolize_names: true),
                  summary: "Successful request",
                  description: "Returns an array of all organisations with summary data",
                },
              },
            },
          }
        end

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body).count).to eq 1196
        end
      end
    end
  end

  path "/organisation_searches" do
    post("Search organisations matching one or more, partial or complete, search terms/words") do
      description "<code>POST</code> a JSON payload containing search terms to
                  receive a response containing an array of organisation names and related data."
      let(:filters) { { search_term: } }
      let(:search_term) { "Babergh" }

      tags "Organisations"
      consumes "application/json"
      produces "application/json"
      parameter name: :filters, in: :body, schema: {
        type: :object,
        properties: {
          search_term: { type: :string,
                         example: "babergh",
                         description: "search term" },
        },
        required: %w[search_term],
      }

      response(200, "success") do
        context "when the search is successful" do
          expected_response =
            {
              success: true,
              data:
                [
                  {
                    name: "Babergh District Council",
                    ccms_opponent_id: "280370",
                    ccms_type_code: "LA",
                    ccms_type_text: "Local Authority",
                  },
                ],
            }

          example "application/json",
                  :success,
                  expected_response,
                  "Single success",
                  "When a user requests a single match it is returned"
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.media_type).to eql("application/json")
            expect(parsed_response).to eq expected_response
          end
        end

        context "when no matches found" do
          let(:search_term) { "nonexistant" }

          expected_response =
            {
              success: false,
              data: [],
            }

          example "application/json",
                  :no_matches_found,
                  expected_response,
                  "When no matching organisation exists",
                  <<~EXPLAIN
                    If a user requests data for a search term that does not exist the system has not
                    errored so returns a successful status (200) but an empty array and a success false
                  EXPLAIN
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.media_type).to eql("application/json")
            expect(parsed_response).to eq expected_response
          end
        end

        context "when multiple matches are found" do
          let(:filters) do
            { search_term: "pub lim comp" }
          end

          expected_response =
            {
              success: true,
              data:
                [
                  {
                    name: "G4S",
                    ccms_opponent_id: "381576",
                    ccms_type_code: "PLC",
                    ccms_type_text: "Public Limited Company",
                  },
                  {
                    name: "Imperial College London",
                    ccms_opponent_id: "381577",
                    ccms_type_code: "PLC",
                    ccms_type_text: "Public Limited Company",
                  },
                  {
                    name: "University North Durham",
                    ccms_opponent_id: "381578",
                    ccms_type_code: "PLC",
                    ccms_type_text: "Public Limited Company",
                  },
                ],
            }

          example "application/json",
                  :multiple_results,
                  expected_response,
                  "Multiple results",
                  "When searching for a organisation type that matches multiple organisations they are all returned"
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.media_type).to eql("application/json")
            expect(parsed_response).to eq expected_response
          end
        end
      end

      response(400, "bad request") do
        before do
          allow(OrganisationFullTextSearch).to receive(:call).and_raise(StandardError.new("Unexpected error in full text search"))
        end

        expected_response =
          {
            success: false,
            error: "StandardError",
            message: "Unexpected error in full text search",
          }
        example "application/json",
                :search_failed,
                expected_response,
                "Unexpected Error",
                "When an error occurs in the full text search"

        run_test! do |response|
          expect(response).to have_http_status(:bad_request)
          expect(response.media_type).to eql("application/json")
          expect(parsed_response).to match_json_expression(expected_response)
        end
      end
    end
  end
end
