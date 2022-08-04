class ProceedingTypeServiceLevelsService
  def self.call(proceeding_type_levels_of_service_params:)
    new(proceeding_type_levels_of_service_params).call
  end

  def initialize(proceeding_type_levels_of_service_params)
    @proceeding_type_levels_of_service_params = proceeding_type_levels_of_service_params
    @errors = []
  end

  def call
    if json_validator.valid?
      @response = create_skeleton_response
      add_level_of_service_to_response
      @response
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

  def add_level_of_service_to_response
    sl = ServiceLevel.find_by!(level: level_of_service_code)
    @response[:level_of_service] = { level: sl.level, name: sl.name, stage: sl.stage, scope_limitations: }
  end

  def scope_limitations
    scope_limitations = []
    scopes = ScopeLimitation.joins("INNER JOIN proceeding_type_scopes ON proceeding_type_scopes.scope_limitation_code=scope_limitations.code").where(proceeding_type_scopes: { proceeding_type_ccms_code:, df_used: delegated_functions_used, client_involvement_type_code: client_involvement_type, service_level: level_of_service_code }).order(:meaning)
    scopes.each do |sl|
      scope_limitations << { code: sl.code, meaning: sl.meaning, description: sl.description, additional_params: [] }
    end
    scope_limitations
  end

  def proceeding_type_ccms_code
    @proceeding_type_ccms_code ||= JSON.parse(@proceeding_type_levels_of_service_params, symbolize_names: true)[:proceeding_type_ccms_code]
  end

  def delegated_functions_used
    @delegated_functions_used ||= JSON.parse(@proceeding_type_levels_of_service_params, symbolize_names: true)[:delegated_functions_used]
  end

  def client_involvement_type
    @client_involvement_type ||= JSON.parse(@proceeding_type_levels_of_service_params, symbolize_names: true)[:client_involvement_type]
  end

  def level_of_service_code
    @level_of_service_code ||= JSON.parse(@proceeding_type_levels_of_service_params, symbolize_names: true)[:level_of_service_code]
  end

  def error_response
    {
      success: false,
      errors: @errors,
    }
  end

  def json_validator
    @json_validator ||= JsonValidator.new("proceeding_type_levels_of_service", @proceeding_type_levels_of_service_params)
  end
end
