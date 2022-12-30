require "rails_helper"

RSpec.describe QuestionsService do
  subject(:question_service) { described_class.call(question_params) }

  let(:question_params) do
    {
      request_id:,
      proceedings:,
    }.to_json
  end
  let(:request_id) { SecureRandom.uuid }
  let(:proceedings) do
    [
      {
        ccms_code:,
        delegated_functions_used: true,
        client_involvement_type:,
      },
    ]
  end
  let(:ccms_code) { "DA005" }
  let(:client_involvement_type) { "A" }

  context "when the request succeeds" do
    context "when there is a DA proceeding with CIT of applicant" do
      it "returns valid response with expected tasks" do
        expect(question_service).to eq expected_da005_applicant_response
      end
    end

    context "when there is a DA proceeding with CIT of Defendant" do
      let(:client_involvement_type) { "D" }

      it "returns valid response with questions 7 & 8" do
        expect(question_service).to eq expected_da005_defendant_response
      end
    end

    context "when there is a DA proceeding as Applicant and a Child Section 8 with CIT of Defendant" do
      let(:proceedings) do
        [
          {
            ccms_code: "DA005",
            delegated_functions_used: true,
            client_involvement_type: "A",
          },
          {
            ccms_code: "SE013",
            delegated_functions_used: true,
            client_involvement_type: "D",
          },
        ]
      end

      it "returns valid response without domestic abuse/non applicant questions" do
        expect(question_service).to eq expected_multiple_no_questions_response_with_defendant
      end
    end

    context "when there is a DA proceeding as Applicant and a Child Section 8 as Applicant" do
      let(:proceedings) do
        [
          {
            ccms_code: "DA005",
            delegated_functions_used: true,
            client_involvement_type: "A",
          },
          {
            ccms_code: "SE013",
            delegated_functions_used: true,
            client_involvement_type: "A",
          },
        ]
      end

      it "returns valid response without domestic abuse/non applicant questions" do
        expect(question_service).to eq expected_multiple_no_questions_response
      end
    end

    context "when there are two DA proceedings with one as Applicant and one as Defendant" do
      let(:proceedings) do
        [
          {
            ccms_code: "DA001",
            delegated_functions_used: false,
            client_involvement_type: "A",
          },
          {
            ccms_code: "DA005",
            delegated_functions_used: false,
            client_involvement_type: "D",
          },
        ]
      end

      it "returns valid response that includes the latest_incident_details questions" do
        expect(question_service).to eq expected_latest_incident_details_response
      end
    end
  end

  context "when the request fails" do
    context "when no proceedings data is supplied" do
      let(:proceedings) { [] }

      it "returns error" do
        response = question_service
        expect(response[:success]).to be false
        expect(response[:errors]).to match [/The property '#\/proceedings' did not contain a minimum number of items 1 in schema file/]
      end
    end

    context "with a non_existent client_involvement_type" do
      let(:client_involvement_type) { "X" }

      it "returns error" do
        response = question_service
        expect(response[:success]).to be false
        expect(response[:errors]).to match [/The property '#\/proceedings\/0\/client_involvement_type' value "X" did not match one of the following values: .* in schema file/]
      end
    end
  end

  def expected_latest_incident_details_response
    {
      request_id:,
      success: true,
      application: {
        tasks: {
          "latest_incident_details" => [],
          "client_denial_of_allegation" => [],
          "client_offer_of_undertakings" => [],
          "opponent_name" => [],
          "opponent_mental_capacity" => [],
          "domestic_abuse_summary" => [],
          "statement_of_case" => [],
        },
      },
      proceedings: [
        {
          ccms_code: "DA001",
          tasks: {
            "chances_of_success" => [],
          },
        },
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

  def expected_da005_applicant_response
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
      proceedings: [
        {
          ccms_code: "DA005",
          tasks: {
            "chances_of_success" => [],
          },
        },
      ],
    }
  end

  def expected_da005_defendant_response
    {
      request_id:,
      success: true,
      application: {
        tasks: {
          "opponent_name" => [],
          "opponent_mental_capacity" => [],
          "statement_of_case" => [],
          "client_denial_of_allegation" => [],
          "client_offer_of_undertakings" => [],
          "nature_of_urgency" => [],
        },
      },
      proceedings: [
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

  def expected_multiple_no_questions_response
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
          "nature_of_urgency" => [],
          "why_matter_opposed" => [],
        },
      },
      proceedings: [
        {
          ccms_code: "DA005",
          tasks: {
            "chances_of_success" => [],
          },
        },
        {
          ccms_code: "SE013",
          tasks: {
            "chances_of_success" => [],
            "children_proceeding" => %w[children_application],
            "attempts_to_settle" => [],
          },
        },
      ],
    }
  end

  def expected_multiple_no_questions_response_with_defendant
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
          "nature_of_urgency" => [],
          "why_matter_opposed" => [],
        },
      },
      proceedings: [
        {
          ccms_code: "DA005",
          tasks: {
            "chances_of_success" => [],
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
