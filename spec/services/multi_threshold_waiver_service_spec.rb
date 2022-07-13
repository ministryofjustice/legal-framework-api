require "rails_helper"

RSpec.describe MultiThresholdWaiverService do
  subject(:multi_threshold_waiver_service_response) { described_class.call(request_id, values) }

  before { seed_live_data }

  let(:request_id) { SecureRandom.uuid }

  context "when the request is successful" do
    context "with a domestic abuse proceeding type" do
      let(:values) do
        [
          {
            ccms_code: "DA005",
            client_involvement_type: "A",
          },
        ]
      end

      it "returns valid response with expected tasks" do
        expect(multi_threshold_waiver_service_response).to eq expected_da005_response
      end
    end

    context "with domestic abuse and section 8 proceeding types" do
      let(:values) do
        [
          {
            ccms_code: "DA005",
            client_involvement_type: "A",
          },
          {
            ccms_code: "SE003",
            client_involvement_type: "A",
          },
          {
            ccms_code: "SE013",
            client_involvement_type: "D",
          },
        ]
      end

      it "returns response with dependencies" do
        expect(multi_threshold_waiver_service_response).to eq expected_da005_se003_se013_response
      end
    end
  end

  context "when the request is unsuccessful" do
    context "with a non_existent ccms_code" do
      let(:values) do
        [
          {
            ccms_code: "XX001",
            client_involvement_type: "A",
          },
        ]
      end

      it "returns error" do
        response = multi_threshold_waiver_service_response
        expect(response[:request_id]).to eq request_id
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq "ActiveRecord::RecordNotFound"
        expect(response[:message]).to match "Couldn't find ProceedingType"
        expect(response[:backtrace]).to be_instance_of(Array)
      end
    end

    context "with a non_existent client_involvement_type" do
      let(:values) do
        [
          {
            ccms_code: "DA001",
            client_involvement_type: "X",
          },
        ]
      end

      it "returns error" do
        response = multi_threshold_waiver_service_response
        expect(response[:request_id]).to eq request_id
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq "ActiveRecord::RecordNotFound"
        expect(response[:message]).to match "Couldn't find ClientInvolvementType"
        expect(response[:backtrace]).to be_instance_of(Array)
      end
    end

    context "with no proceeding data specified" do
      let(:values) { [] }

      it "returns error" do
        response = multi_threshold_waiver_service_response
        expect(response[:request_id]).to eq request_id
        expect(response[:success]).to be false
        expect(response[:error_class]).to eq "MultiThresholdWaiverService::MultiThresholdWaiverServiceError"
        expect(response[:message]).to eq "Must specify at least one proceeding type"
        expect(response[:backtrace]).to be_instance_of(Array)
      end
    end
  end

  def expected_da005_response
    {
      request_id:,
      success: true,
      proceedings: [
        {
          ccms_code: "DA005",
          client_involvement_type: "A",
          capital_upper: true,
          disposable_income_upper: true,
          gross_income_upper: true,
          matter_type: "Domestic abuse",
        },
      ],
    }
  end

  def expected_da005_se003_se013_response
    {
      request_id:,
      success: true,
      proceedings: [
        {
          ccms_code: "DA005",
          client_involvement_type: "A",
          capital_upper: true,
          disposable_income_upper: true,
          gross_income_upper: true,
          matter_type: "Domestic abuse",
        },
        {
          ccms_code: "SE003",
          client_involvement_type: "A",
          capital_upper: false,
          disposable_income_upper: false,
          gross_income_upper: false,
          matter_type: "Children - section 8",
        },
        {
          ccms_code: "SE013",
          client_involvement_type: "D",
          capital_upper: false,
          disposable_income_upper: false,
          gross_income_upper: false,
          matter_type: "Children - section 8",
        },
      ],
    }
  end
end
