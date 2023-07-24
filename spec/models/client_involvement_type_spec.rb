require "rails_helper"

RSpec.describe ClientInvolvementType do
  subject(:client_involvement_type) { create(:client_involvement_type) }

  it { is_expected.to respond_to(:ccms_code, :description, :ordering) }

  it { is_expected.to validate_inclusion_of(:ccms_code).in_array(described_class::VALID_CLIENT_INVOLVEMENT_TYPES).with_message(/is not a valid client_involvement_type/) }

  describe "#api_json" do
    subject(:api_json) { client_involvement_type.api_json }

    it "returns the expected json keys" do
      expect(api_json.keys).to match_array(%w[ccms_code description])
    end
  end
end
