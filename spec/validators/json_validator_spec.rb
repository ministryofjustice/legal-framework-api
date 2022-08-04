require "rails_helper"

RSpec.describe "JsonValidator" do
  let(:payload) do
    {
      proceeding_type_ccms_code:,
      delegated_functions_used:,
      client_involvement_type:,
      level_of_service_code:,
    }.to_json
  end

  let(:proceeding_type_ccms_code) { "SE014" }
  let(:delegated_functions_used) { false }
  let(:client_involvement_type) { "W" }
  let(:level_of_service_code) { 3 }

  let(:schema_name) { "proceeding_type_levels_of_service" }

  let(:validator) { JsonValidator.new(schema_name, payload) }

  context "when valid payload" do
    it { expect(validator).to be_valid }
  end

  context "when proceeding_type_ccms_code is invalid and client_involvement_type is invalid" do
    let(:proceeding_type_ccms_code) { "XX123" }
    let(:client_involvement_type) { "X" }

    it { expect(validator).not_to be_valid }

    it "displays errors" do
      expect(validator.errors)
        .to include(match(/The property '#\/proceeding_type_ccms_code' value "XX123" did not match one of the following values: .* in schema file/))
        .and include(match(/The property '#\/client_involvement_type' value "X" did not match one of the following values: .* in schema file/))
    end
  end

  context "when not all required elements are present" do
    let(:payload) do
      {
        proceeding_type_ccms_code:,
        delegated_functions_used:,
        client_involvement_type:,
      }.to_json
    end

    it { expect(validator).not_to be_valid }

    it "has the expected errors" do
      expect(validator.errors)
        .to match([/The property '#\/' did not contain a required property of 'level_of_service_code' in schema file/])
    end
  end
end
