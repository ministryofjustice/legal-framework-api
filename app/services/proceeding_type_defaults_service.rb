class ProceedingTypeDefaultsService
  def self.call(proceeding_type_defaults_params:)
    new(proceeding_type_defaults_params).call
  end

  def initialize(proceeding_type_defaults_params)
    @proceeding_type_defaults_params = proceeding_type_defaults_params
    @errors = []
  end

  def call
    if json_validator.valid?
      @response = create_skeleton_response
      add_default_service_level_to_response
      add_default_scope_to_response
      add_additional_params_to_response
    else
      @response = error_response
      @errors.concat(json_validator.errors)
    end
    @response
  end

private

  def create_skeleton_response
    {
      success: true,
      requested_params: {
        proceeding_type_ccms_code:,
        delegated_functions_used:,
        client_involvement_type:,
        level_of_service_code:,
      },
    }
  end

  def add_default_service_level_to_response
    dsl = ServiceLevel.includes(:proceeding_types, :proceeding_type_service_levels).find_by!(proceeding_types: { ccms_code: proceeding_type_ccms_code }, proceeding_type_service_levels: { proceeding_default: true })
    @response[:default_level_of_service] = { level: dsl.level, name: dsl.name, stage: dsl.stage }
  end

  def add_default_scope_to_response
    ds = ScopeLimitation.default_for(proceeding_type_ccms_code, client_involvement_type, level_of_service_code, delegated_functions_used)
    @response[:default_scope] = { code: ds.code, description: ds.description, meaning: ds.meaning }
  end

  def add_additional_params_to_response
    # TODO: populate additional params once scopes that require it populated
    @response[:additional_params] = []
  end

  def proceeding_type_ccms_code
    @proceeding_type_ccms_code ||= JSON.parse(@proceeding_type_defaults_params, symbolize_names: true)[:proceeding_type_ccms_code]
  end

  def delegated_functions_used
    @delegated_functions_used ||= JSON.parse(@proceeding_type_defaults_params, symbolize_names: true)[:delegated_functions_used]
  end

  def client_involvement_type
    @client_involvement_type ||= JSON.parse(@proceeding_type_defaults_params, symbolize_names: true)[:client_involvement_type]
  end

  def level_of_service_code
    @level_of_service_code ||= JSON.parse(@proceeding_type_defaults_params, symbolize_names: true)[:level_of_service_code]
  end

  def error_response
    {
      success: false,
      errors: @errors,
    }
  end

  def json_validator
    @json_validator ||= JsonValidator.new("proceeding_type_scopes", @proceeding_type_defaults_params)
  end
end
