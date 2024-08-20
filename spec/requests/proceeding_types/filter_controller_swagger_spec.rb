require "swagger_helper"

RSpec.describe "proceeding_types/filter_controller" do
  path "/proceeding_types/filter" do
    post("Get available proceeding types dependant on current proceedings, contractual data and search terms") do
      description "Returns an array of proceeding types with summary data.
                   Call <code>/proceeding_types/XX999</code> where <code>XX999</code> is the ccms_code for more
                   detailed data on a specific proceeding type."

      let(:parameters) do
        {
          current_proceedings:,
          allowed_categories:,
          search_term:,
        }
      end
      let(:current_proceedings) { [] }
      let(:allowed_categories) { [] }
      let(:search_term) { "" }

      tags "Proceeding types"
      consumes "application/json"
      produces "application/json"
      parameter name: :parameters, in: :body, schema: {
        type: :object,
        properties: {
          current_proceedings: { type: :array,
                                 example: %w[DA001 DA007 SE013],
                                 description: "comma separated array of ccms codes to exclude from search results and provide filter options" },
          allowed_categories: { type: :array,
                                example: %w[MAT],
                                description: "comma separated array of category of law codes that the current user is contractually entitled to" },
          search_term: { type: :string,
                         example: "Occupation",
                         description: "search term that should be included in the proceeding description" },
        },
      }

      response(200, "success") do
        context "when the search is successful" do
          example "application/json",
                  :success,
                  {
                    success: true,
                    data:
                      [
                        {
                          meaning: "Occupation order",
                          ccms_code: "DA005",
                          description: "to be represented on an application for an occupation order.",
                          full_s8_only: false,
                          sca_core: false,
                          sca_related: false,
                          ccms_category_law: "Family",
                          ccms_matter: "Domestic abuse",
                        },
                        {
                          continued: "...",
                        },
                      ],
                  },
                  "Single success",
                  "When a user requests a single match it is returned"
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.media_type).to eql("application/json")
          end
        end

        context "when the category is not yet supported in LFA" do
          let(:allowed_categories) { %w[MED] }

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
                    If a user requests a category that is not yet supported the system has not
                    errored so returns a successful status (200) but an empty array and a success false
                  EXPLAIN
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.media_type).to eql("application/json")
            expect(parsed_response).to eq expected_response
          end
        end
      end
    end
  end
end
