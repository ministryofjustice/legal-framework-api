require "swagger_helper"

RSpec.describe "proceeding_types/searches_controller" do
  path "/proceeding_types/all" do
    get("Get summary of all proceeding types") do
      description "Returns an array of all proceeding types with summary data.
                   Call <code>/proceeding_types/XX999</code> where <code>XX999</code> is the ccms_code for more
                   detailed data on a specific proceeding type."

      tags "Proceeding types"
      produces "application/json"

      response(200, "successful") do
        after do |example|
          example.metadata[:response][:content] = {
            "application/json": {
              examples: {
                success: {
                  value: JSON.parse(response.body, symbolize_names: true),
                  summary: "Successful request",
                  description: "Returns an array of all proceeding types with summary data",
                },
              },
            },
          }
        end

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body).count).to eq 156
        end
      end
    end
  end

  path "/proceeding_types/searches" do
    post("Search proceeding types matching a search term, optionally excluding some ccms_codes") do
      description "<code>POST</code> a JSON payload containing search terms and a list of codes to exclude to
                  receive a response containing an array of proceeding types with summary data"
      let(:filters) do
        {
          search_term:,
          excluded_codes: "DA001,DA007,SE013",
        }
      end
      let(:search_term) { "Occupation" }

      tags "Proceeding types"
      consumes "application/json"
      produces "application/json"
      parameter name: :filters, in: :body, schema: {
        type: :object,
        properties: {
          search_term: { type: :string,
                         example: "Occupation",
                         description: "search term" },
          excluded_codes: { type: :string,
                            example: "DA001,DA007,SE013",
                            description: "comma separated list of ccms codes to exclude from search results" },
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
                    meaning: "Occupation order",
                    ccms_code: "DA005",
                    description: "to be represented on an application for an occupation order.",
                    sca_core: false,
                    sca_related: false,
                    non_means_tested_plf: false,
                    ccms_category_law: "Family",
                    ccms_category_law_code: "MAT",
                    ccms_matter: "domestic abuse (DA)",
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

        context "and no matches found" do
          let(:search_term) { "nonexistant" }

          expected_response =
            {
              success: false,
              data: [],
            }

          example "application/json",
                  :no_matches_found,
                  expected_response,
                  "When only result excluded",
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

        context "and multiple matches are found" do
          let(:filters) do
            { search_term: "injunction" }
          end

          expected_response =
            {
              success: true,
              data:
                [
                  {
                    meaning: "Inherent jurisdiction - high court injunction",
                    ccms_code: "DA001",
                    description: "to be represented on an application for an injunction, order or declaration under the inherent jurisdiction of the court.",
                    sca_core: false,
                    sca_related: false,
                    non_means_tested_plf: false,
                    ccms_category_law: "Family",
                    ccms_category_law_code: "MAT",
                    ccms_matter: "domestic abuse (DA)",
                  },
                  {
                    meaning: "Harassment - injunction",
                    ccms_code: "DA003",
                    description: "to be represented in an action for an injunction under section 3 Protection from Harassment Act 1997.",
                    sca_core: false,
                    sca_related: false,
                    non_means_tested_plf: false,
                    ccms_category_law: "Family",
                    ccms_category_law_code: "MAT",
                    ccms_matter: "domestic abuse (DA)",
                  },
                  {
                    meaning: "Non-molestation order",
                    ccms_code: "DA004",
                    description: "to be represented on an application for a non-molestation order.",
                    sca_core: false,
                    sca_related: false,
                    non_means_tested_plf: false,
                    ccms_category_law: "Family",
                    ccms_category_law_code: "MAT",
                    ccms_matter: "domestic abuse (DA)",
                  },
                ],
            }

          example "application/json",
                  :multiple_results,
                  expected_response,
                  "Multiple results",
                  "When searching for a description that matches multiple proceedings they are all returned"
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.media_type).to eql("application/json")
            expect(parsed_response).to eq expected_response
          end
        end

        context "when the search term is excluded" do
          let(:filters) do
            {
              search_term: "occupation",
              excluded_codes: "DA005",
            }
          end

          expected_response =
            {
              success: false,
              data: [],
            }

          example "application/json",
                  :only_result_is_excluded,
                  expected_response,
                  "When only result excluded",
                  <<~EXPLAIN
                    If a user requests data for a search term, with an exclusion that removes the only response the
                    system has not errored so returns a successful status (200) but an empty array and a success false
                  EXPLAIN
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.media_type).to eql("application/json")
            expect(parsed_response).to eq expected_response
          end
        end
      end

      response(400, "bad request") do
        before do
          allow(ProceedingTypeFullTextSearch).to receive(:call).and_raise(StandardError.new("Unexpected error in full text search"))
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
