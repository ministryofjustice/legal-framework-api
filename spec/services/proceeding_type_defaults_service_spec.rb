require "rails_helper"

RSpec.describe ProceedingTypeDefaultsService do
  subject(:proceeding_type_default_response) { described_class.call(proceeding_type_defaults_params:) }

  let(:proceeding_type_defaults_params) do
    {
      proceeding_type_ccms_code:,
      delegated_functions_used:,
      client_involvement_type:,
    }.to_json
  end
  let(:proceeding_type_ccms_code) { "SE003" }
  let(:delegated_functions_used) { true }
  let(:client_involvement_type) { "D" }
  let(:level_of_service_code) { 1 }

  context "when the request is successful" do
    it "returns valid response with expected defaults" do
      expect(proceeding_type_default_response).to eq expected_successful_response
    end
  end

  context "when the request is unsuccessful" do
    context "with a non_existent client_involvement_type" do
      let(:client_involvement_type) { "X" }

      it "returns error" do
        response = proceeding_type_default_response
        expect(response[:success]).to be false
        expect(response[:errors]).to match [/The property '#\/client_involvement_type' value "X" did not match one of the following values: .* in schema file/]
      end
    end
  end

  describe "data integrity" do
    let(:scenarios) do
      [
        [:section_8_base, :cit_a, :df_used, 1, "CV117"],
        [:section_8_base, :cit_a, :substantive, 1, "FM059"],
        [:section_8_base, :cit_not_a, :df_used, 1, "CV118"],
        [:section_8_base, :cit_not_a, :substantive, 1, "FM059"],

        [:section_8_appeals, :cit_a, :df_used, 3, "CV118"],
        [:section_8_appeals, :cit_a, :substantive, 3, "CV079"],
        [:section_8_appeals, :cit_not_a, :df_used, 3, "CV118"],
        [:section_8_appeals, :cit_not_a, :substantive, 3, "CV079"],

        [:section_8_enforcements, :cit_a, :df_used, 3, "FM019"],
        [:section_8_enforcements, :cit_a, :substantive, 3, "FM019"],
        [:section_8_enforcements, :cit_not_a, :df_used, 3, "FM019"],
        [:section_8_enforcements, :cit_not_a, :substantive, 3, "FM019"],

        [:domestic_abuse, :cit_a, :df_used, 3, "CV117"],
        [:domestic_abuse, :cit_a, :substantive, 3, "AA019"],
        [:domestic_abuse, :cit_not_a, :df_used, 3, "CV118"],
        [:domestic_abuse, :cit_not_a, :substantive, 3, "AA019"],
      ]
    end

    let(:section_8_base) { %w[SE003 SE004 SE007 SE008 SE013 SE014 SE015 SE016 SE095 SE097].sample }
    let(:section_8_appeals) { %w[SE003A SE004A SE007A SE008A SE013A SE014A SE015A SE016A SE095A SE097A SE101A].sample }
    let(:section_8_enforcements) { %w[SE003E SE004E SE007E SE008E SE013E SE014E SE015E SE016E SE096E SE099E SE100E SE101E].sample }
    let(:domestic_abuse) { %w[DA001 DA002 DA003 DA004 DA005 DA006 DA007 DA020].sample  }
    let(:cit_a) { "A" }
    let(:cit_not_a) { %w[D I W Z].sample }
    let(:df_used) { true }
    let(:substantive) { false }

    it "generates the expected default service level and scope" do
      scenarios.each do |scenario|
        proceeding_type_code, client_involvement_type, df_used, expected_level, expected_scope = scenario
        payload = generate_payload(proceeding_type_code, client_involvement_type, df_used)
        response = described_class.call(proceeding_type_defaults_params: payload.to_json)
        expect(parse_response(response)).to eq([expected_level, expected_scope])
      end
    end
  end

  def generate_payload(proceeding_type_code, client_involvement_type, df_used)
    {
      proceeding_type_ccms_code: __send__(proceeding_type_code),
      delegated_functions_used: __send__(df_used),
      client_involvement_type: __send__(client_involvement_type),
    }
  end

  def parse_response(response)
    default_service_level = response[:default_level_of_service][:level]
    default_scope = response[:default_scope][:code]
    [default_service_level, default_scope]
  end

  def expected_successful_response
    {
      success: true,
      requested_params: {
        proceeding_type_ccms_code: "SE003",
        delegated_functions_used: true,
        client_involvement_type: "D",
      },
      default_level_of_service: {
        level: 1,
        name: "Family Help (Higher)",
        stage: 1,
      },
      default_scope: {
        code: "CV118",
        meaning: "Hearing",
        description: "Limited to all steps up to and including the hearing on [see additional limitation notes]",
        additional_params: [
          {
            name: "hearing_date",
            type: "date",
            mandatory: true,
          },
        ],
      },
    }
  end
end
