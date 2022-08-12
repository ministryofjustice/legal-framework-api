class ScopeLimitation < ApplicationRecord
  has_many :proceeding_type_scope_limitations, dependent: :destroy
  has_many :proceeding_types, through: :proceeding_type_scope_limitations
  has_many :scope_limitation_user_inputs
  has_many :user_inputs,
           source: :scope_user_input,
           through: :scope_limitation_user_inputs,
           class_name: "ScopeUserInput"

  def self.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
    codes = EligibleScopesService.eligible_scopes(pt_ccms_code, client_involvement_type, service_level, df_used)
    recs = where(code: codes)
    raise "Scope Limitation record(s) not found for #{codes.join(', ')}" if recs.size != codes.size

    recs
  end

  def self.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
    sl_code = EligibleScopesService.default_scope(pt_ccms_code, client_involvement_type, service_level, df_used)

    find_by!(code: sl_code)
  end
end
