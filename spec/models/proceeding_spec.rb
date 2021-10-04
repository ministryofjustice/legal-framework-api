require 'rails_helper'

RSpec.describe Proceeding do
  it { is_expected.to respond_to(:proceeding_type, :legal_aid_application_id, :proceeding_case_id, :used_delegated_functions_on, :used_delegated_functions_reported_on) }
end
