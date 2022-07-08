require "rails_helper"

RSpec.describe ClientInvolvementType, type: :model do
  it { is_expected.to respond_to(:ccms_code, :description) }
end
