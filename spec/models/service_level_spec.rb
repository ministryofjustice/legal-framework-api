require "rails_helper"

RSpec.describe ServiceLevel do
  it { is_expected.to have_many(:proceeding_type_service_levels).dependent(:destroy) }
  it { is_expected.to have_many(:proceeding_types).through(:proceeding_type_service_levels) }

  # OPTIMIZE: not convinced this test is better than the shoulda-matchers, above, which are
  # briefer, clear english description, fails under the same circumstances
  # and with a much clearer error message.
  describe "#proceeding_types" do
    subject(:proceeding_types) { service_level.proceeding_types }

    let(:service_level) { create :service_level }
    let(:proceeding_type1) { create :proceeding_type }
    let(:proceeding_type2) { create :proceeding_type }

    before do
      create(:proceeding_type_service_level, :as_default, service_level:, proceeding_type: proceeding_type1)
      create(:proceeding_type_service_level, :as_non_default, service_level:, proceeding_type: proceeding_type2)
      create(:proceeding_type)
    end

    it "returns associated proceeding_types" do
      expect(proceeding_types).to match_array [proceeding_type1, proceeding_type2]
    end
  end
end
