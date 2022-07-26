require "rails_helper"

RSpec.describe ClientInvolvementType, type: :model do
  it { is_expected.to respond_to(:ccms_code, :description, :ordering) }

  describe ".api_json" do
    subject(:api_json) { create(:client_involvement_type).api_json }

    it "returns the expected json keys" do
      expect(JSON.parse(api_json).keys).to match_array(%w[ccms_code description ordering])
    end
  end
end
