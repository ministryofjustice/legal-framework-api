require "rails_helper"

RSpec.describe ServiceLevel do
  it { is_expected.to have_many(:proceeding_type_service_levels).dependent(:destroy) }
  it { is_expected.to have_many(:proceeding_types).through(:proceeding_type_service_levels) }
end
