require "swagger_helper"

RSpec.describe "expert_types" do
  path "/expert_types" do
    get("Get all expert types") do
      description "Returns an array of all expert types with codes."

      tags "Expert types"

      produces "application/json"

      response(200, "successful") do
        expected_example = [
          { "code" => "ACCT", "description" => "Accountant" },
          { "code" => "ARCHT", "description" => "Architect" },
          { "code" => "VET", "description" => "Vet" },
        ]

        example "application/json",
                :success,
                expected_example,
                "Successful request",
                "Returns an array of all expert types with codes."

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body).count).to eq 113
        end
      end
    end
  end
end
