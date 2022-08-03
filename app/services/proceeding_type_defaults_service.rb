class ProceedingTypeDefaultsService
  def self.call(proceeding_type_ccms_code:, delegated_functions_used:, client_involvement_type:, level_of_service_code:)
    new(proceeding_type_ccms_code, delegated_functions_used, client_involvement_type, level_of_service_code).call
  end

  def initialize(proceeding_type_ccms_code, delegated_functions_used, client_involvement_type, level_of_service_code)
    @proceeding_type_ccms_code = proceeding_type_ccms_code
    @delegated_functions_used = delegated_functions_used
    @client_involvement_type = client_involvement_type
    @level_of_service_code = level_of_service_code
    @response = create_skeleton_response
  end

  def call
    add_default_service_level_to_response
    add_default_scope_to_response
    add_additional_params_to_response
    @response
  rescue StandardError => e
    @response = error_response_for(e)
  end

private

  def create_skeleton_response
    {
      success: true,
      requested_params: {
        proceeding_type_ccms_code: @proceeding_type_ccms_code,
        delegated_functions_used: @delegated_functions_used,
        client_involvement_type: @client_involvement_type,
        level_of_service_code: @level_of_service_code,
      },
    }
  end

  def add_default_service_level_to_response
    dsl = ServiceLevel.includes(:proceeding_types, :proceeding_type_service_levels).find_by!(proceeding_types: { ccms_code: @proceeding_type_ccms_code }, proceeding_type_service_levels: { proceeding_default: true })
    @response[:default_level_of_service] = { level: dsl.level, name: dsl.name, stage: dsl.stage }
  end

  def add_default_scope_to_response
    ds = ScopeLimitation.default_for(@proceeding_type_ccms_code, @client_involvement_type, @level_of_service_code, @delegated_functions_used)
    @response[:default_scope] = { code: ds.code, description: ds.description, meaning: ds.meaning }
  end

  def add_additional_params_to_response
    # TODO: populate additional params once scopes that require it populated
    @response[:additional_params] = []
  end

  def error_response_for(err)
    {
      success: false,
      error_class: err.class.to_s,
      message: err.message,
      backtrace: err.backtrace,
    }
  end
end
