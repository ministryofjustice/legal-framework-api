class ScopeLimitation < ApplicationRecord
  has_many :proceeding_type_scope_limitations, dependent: :destroy
  has_many :proceeding_types, through: :proceeding_type_scope_limitations
  has_many :scope_limitation_user_inputs
  has_many :user_inputs,
           source: :scope_user_input,
           through: :scope_limitation_user_inputs,
           class_name: "ScopeUserInput"

  def self.eligible_for(pt_ccms_code, client_involvement_type, service_level, df_used)
    codes = ProceedingTypeScope.where(proceeding_type_ccms_code: pt_ccms_code,
                                      service_level:,
                                      client_involvement_type_code: client_involvement_type,
                                      df_used:).pluck(:scope_limitation_code)
    where(code: codes)
  end

  def self.default_for(pt_ccms_code, client_involvement_type, service_level, df_used)
    rec = ProceedingTypeScope.find_by!(proceeding_type_ccms_code: pt_ccms_code,
                                       service_level:,
                                       client_involvement_type_code: client_involvement_type,
                                       df_used:,
                                       default: true)
    find_by!(code: rec.scope_limitation_code)
  end
end
