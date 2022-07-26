class ProceedingTypeScope < ApplicationRecord
  validate :valid_proceeding_type_code,
           :valid_service_level,
           :valid_client_involvement_type,
           :valid_scope_limitation,
           :only_one_default_in_group

  def valid_proceeding_type_code
    unless proceeding_type_ccms_code.in?(ProceedingType.pluck(:ccms_code))
      errors.add(:proceeding_type_ccms_code, "Code #{proceeding_type_ccms_code} doesn't exist on the proceeding_types table")
    end
  end

  def valid_service_level
    unless service_level.in?(ServiceLevel.pluck(:level))
      errors.add(:service_level, "Service level #{service_level} does not exist in the service_levels table")
    end
  end

  def valid_client_involvement_type
    unless client_involvement_type_code.in?(ClientInvolvementType.pluck(:ccms_code))
      errors.add(:client_involvement_type_code, "CCMS code #{client_involvement_type_code} does not exist in the client_involvement_types table")
    end
  end

  def valid_scope_limitation
    unless scope_limitation_code.in?(ScopeLimitation.pluck(:code))
      errors.add(:scope_limitation_code, "Scope Limitation #{scope_limitation_code} does not exist in the scope_limitations table")
    end
  end

  def only_one_default_in_group
    return if default == false

    pre_existing_default = ProceedingTypeScope.find_by(proceeding_type_ccms_code:,
                                                       service_level:,
                                                       client_involvement_type_code:,
                                                       df_used:,
                                                       default: true)
    if pre_existing_default
      errors.add(:default, "There is already a default scope limitation for this group: #{group_id}")
    end
  end

  def group_id
    "#{proceeding_type_ccms_code}/#{service_level}/#{client_involvement_type_code}/#{df_used}"
  end
end
