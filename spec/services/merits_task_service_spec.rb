require "rails_helper"

RSpec.describe MeritsTaskService do
  subject(:merits_task_service_response) { described_class.call(request_id, ccms_codes) }

  let(:request_id) { SecureRandom.uuid }

  context "when the request is successful" do
    context "with a domestic abuse proceeding type" do
      let(:ccms_codes) { %w[DA005] }

      it "returns valid response with expected tasks" do
        expect(merits_task_service_response).to eq expected_da005_response
      end
    end

    context "with domestic abuse and section 8 proceeding types" do
      let(:ccms_codes) { %w[DA005 SE003 SE013] }

      it "returns response with dependencies" do
        expect(merits_task_service_response).to eq expected_da005_se004_se013_response
      end
    end
  end

  context "when the request is unsuccessful" do
    context "with a non_existent ccms_code" do
      let(:ccms_codes) { %w[XX001] }

      it "returns error" do
        response = merits_task_service_response
        expect(response[:request_id]).to eq request_id
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq "ActiveRecord::RecordNotFound"
        expect(response[:message]).to match(/Couldn't find ProceedingType/)
      end
    end

    context "when no ccms codes are specified" do
      let(:ccms_codes) { [] }

      it "returns error" do
        response = merits_task_service_response
        expect(response[:request_id]).to eq request_id
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq "MeritsTaskService::MeritsTaskServiceError"
        expect(response[:message]).to eq "Must specify at least one proceeding type"
      end
    end
  end

  def expected_da005_response
    {
      request_id:,
      success: true,
      application: {
        tasks: {
          "latest_incident_details" => [],
          "opponent_name" => [],
          "opponent_mental_capacity" => [],
          "domestic_abuse_summary" => [],
          "statement_of_case" => [],
        },
      },
      proceeding_types: [
        {
          ccms_code: "DA005",
          tasks: {
            "chances_of_success" => [],
            "opponents_application" => [],
          },
        },
      ],
    }
  end

  def expected_da005_se004_se013_response
    {
      request_id:,
      success: true,
      application: {
        tasks: {
          "latest_incident_details" => [],
          "opponent_name" => [],
          "opponent_mental_capacity" => [],
          "domestic_abuse_summary" => [],
          "statement_of_case" => [],
          "children_application" => [],
          "laspo" => [],
          "why_matter_opposed" => [],
        },
      },
      proceeding_types: [
        {
          ccms_code: "DA005",
          tasks: {
            "chances_of_success" => [],
            "opponents_application" => [],
          },
        },
        {
          ccms_code: "SE003",
          tasks: {
            "chances_of_success" => [],
            "children_proceeding" => %w[children_application],
            "attempts_to_settle" => [],
            "opponents_application" => [],
            "prohibited_steps" => [],
          },
        },
        {
          ccms_code: "SE013",
          tasks: {
            "chances_of_success" => [],
            "children_proceeding" => %w[children_application],
            "attempts_to_settle" => [],
            "opponents_application" => [],
          },
        },
      ],
    }
  end
end
