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
      populate_instance_vars
      @response = create_skeleton_response
      add_default_service_level_to_response
      add_default_scope_to_response
    else
      @response = error_response
      @errors.concat(json_validator.errors)
    end
    @response
  end

private

  def populate_instance_vars
    hash = JSON.parse(@proceeding_type_defaults_params, symbolize_names: true)
    @proceeding_type_ccms_code = hash[:proceeding_type_ccms_code]
    @delegated_functions_used = hash[:delegated_functions_used]
    @client_involvement_type = hash[:client_involvement_type]
  end

  def create_skeleton_response
    {
      success: true,
      requested_params: {
        proceeding_type_ccms_code: @proceeding_type_ccms_code,
        delegated_functions_used: @delegated_functions_used,
        client_involvement_type: @client_involvement_type,
      },
    }
  end

  def add_default_service_level_to_response
    @level_of_service_code = EligibleScopesService.default_service_level(@proceeding_type_ccms_code)
    sl_record = ServiceLevel.find_by!(level: @level_of_service_code)
    @response[:default_level_of_service] = sl_record.as_json
  end

  def add_default_scope_to_response
    ds = ScopeLimitation.default_for(@proceeding_type_ccms_code, @client_involvement_type, @level_of_service_code, @delegated_functions_used)
    @response[:default_scope] = ds.as_json
  end

  def error_response
    {
      success: false,
      errors: @errors,
    }
  end

  def json_validator
    @json_validator ||= JsonValidator.new("proceeding_type_defaults", @proceeding_type_defaults_params)
  end
end
