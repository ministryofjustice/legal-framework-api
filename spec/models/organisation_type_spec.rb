require "rails_helper"

RSpec.describe OrganisationType do
  subject(:organisation_type) { create(:organisation_type) }

  describe "#api_json" do
    subject(:api_json) { organisation_type.api_json }

    it "returns expected JSON response payload item" do
      expect(api_json).to eql({ "ccms_code" => "CHAR", "description" => "Charity" })
    end
  end
end
