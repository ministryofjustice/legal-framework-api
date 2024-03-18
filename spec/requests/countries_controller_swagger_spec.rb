require "swagger_helper"

RSpec.describe "countries" do
  path "/countries/all" do
    get("Get all countries") do
      description "Returns an array of all countries with summary data."

      tags "Countries"
      produces "application/json"

      response(200, "successful") do
        after do |example|
          example.metadata[:response][:content] = {
            "application/json": {
              examples: {
                success: {
                  value: JSON.parse(response.body, symbolize_names: true),
                  summary: "Successful request",
                  description: "Returns an array of all countries with summary data",
                },
              },
            },
          }
        end

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body).count).to eq 246
        end
      end
    end
  end

  path "/countries/search" do
    post("Search countries matching one or more, partial or complete, search terms/words") do
      description "<code>POST</code> a JSON payload containing search terms to
                  receive a response containing an array of country names and codes."
      let(:filters) { { search_term: } }
      let(:search_term) { "antarc" }

      tags "Countries"
      consumes "application/json"
      produces "application/json"
      parameter name: :filters, in: :body, schema: {
        type: :object,
        properties: {
          search_term: { type: :string,
                         example: "ant",
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
                    description: "Antarctica",
                    code: "ATA",
                    description_headline: "<mark>Antarctica</mark>",
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
                  "When no matching country exists",
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
            { search_term: "co isl" }
          end

          expected_response =
            {
              success: true,
              data:
                [
                  {
                    description: "Cook Islands",
                    code: "COK",
                    description_headline: "<mark>Cook</mark> <mark>Islands</mark>",
                  },
                  {
                    description: "Cocos (Keeling) Islands",
                    code: "CCK",
                    description_headline: "<mark>Cocos</mark> (Keeling) <mark>Islands</mark>",
                  },
                ],
            }

          example "application/json",
                  :multiple_results,
                  expected_response,
                  "Multiple results",
                  "When searching for country that matches multiple countries they are all returned"
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.media_type).to eql("application/json")
            expect(parsed_response).to eq expected_response
          end
        end
      end

      response(400, "bad request") do
        before do
          allow(CountriesFullTextSearch).to receive(:call).and_raise(StandardError.new("Unexpected error in full text search"))
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
