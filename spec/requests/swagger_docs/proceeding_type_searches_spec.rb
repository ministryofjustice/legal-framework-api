require "swagger_helper"

RSpec.describe "ProceedingTypes::SearchesController", type: :request, swagger: true do
  path "/proceeding_types/all" do
    get("Get summary of all proceeding types") do
      tags "Proceeding types"

      produces "application/json"

      response(200, "successful") do
        seed_live_data
        examples "application/json" => ProceedingType.all.map { |pt| JSON.parse(pt.api_json) }
        run_test!
      end
    end
  end

  path "/proceeding_types/searches" do
    post("Search proceeding types matching a search term, optionally excluding some ccms_codes") do
      search_term = "Injunction"
      excluded_codes = "DA001,DA007,SE013"

      tags "Proceeding types"
      consumes "application/json"
      produces "application/json"
      parameter name: :filters, in: :body, schema: {
        type: :object,
        properties: {
          search_term: { type: :string,
                         example: search_term,
                         description: "search term" },
          excluded_codes: { type: :string,
                            example: excluded_codes,
                            description: "comma separated list of ccms codes to exclude from search results" },
        },
        required: %w[search_term],
      }

      response(200, "success") do
        seed_live_data
        results = { data: ProceedingTypeFullTextSearch.call(search_term, excluded_codes) }
        formatted_results = { success: true }.merge(results).to_json

        examples "application/json" => formatted_results
        run_test!
      end
    end
  end
end
