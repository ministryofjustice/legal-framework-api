require "rails_helper"

RSpec.describe ServiceLevel do
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
