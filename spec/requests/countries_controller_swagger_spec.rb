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
end
