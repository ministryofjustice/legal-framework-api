require "swagger_helper"

RSpec.describe "expert_types" do
  path "/expert_types" do
    get("Get all expert types") do
      description "Returns an array of all expert types."
      tags "Expert types"
      produces "application/json"

      response(200, "successful") do
        expected_example = [
          { "code" => "child_psychologist", "description" => "Child Psychologist" },
          { "code" => "independent_social_worker", "description" => "Independent Social Worker" },
          { "code" => "psychologist", "description" => "Psychologist" },
        ]

        example "application/json",
                :success,
                expected_example,
                "Successful request",
                "Returns an array of all expert types."

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body).count).to eq 26
        end
      end
    end
  end

  path "/expert_types/{matter_type}" do
    get("Get expert types for a matter type") do
      description "Returns an array of expert types filtered by the given matter type code. " \
                  "Returns an empty array when the matter type code has no associated expert types."
      tags "Expert types"

      parameter name: "matter_type",
                in: :path,
                type: :string,
                example: "KPBLW",
                description: "Matter type code, e.g. KPBLW"

      produces "application/json"

      response(200, "successful") do
        let(:matter_type) { "KPBLW" }

        expected_example = [
          { "code" => "child_psychologist", "description" => "Child Psychologist" },
          { "code" => "psychologist", "description" => "Psychologist" },
        ]

        example "application/json",
                :success,
                expected_example,
                "Successful request",
                "Returns an array of expert types associated with the matter type code."

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response.media_type).to eql("application/json")
          expect(JSON.parse(response.body).count).to eq 26
          expect(JSON.parse(response.body).first["code"]).to eq("cell_phone_analysis")
        end
      end

      response(200, "successful with no results") do
        let(:matter_type) { "MINJN" }

        example "application/json",
                :empty,
                [],
                "Empty result",
                "Returns an empty array when the matter type code has no associated expert types."

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eq []
        end
      end
    end
  end
end
