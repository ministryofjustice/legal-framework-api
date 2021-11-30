class ProceedingTypeService
  class ProceedingTypeServiceError < StandardError; end

  def self.call(ccms_code)
    new(ccms_code).call
  end

  def initialize(ccms_code)
    @ccms_code = ccms_code
    @response = skeleton_response
  end

  def call
    raise ProceedingTypeServiceError, 'Must specify a proceeding type' if @ccms_code.nil?

    populate_response(@ccms_code)
    @response
  rescue StandardError => err
    @response = error_response_for(err)
  end

  private

  def populate_response(ccms_code)
    pt = ProceedingType.find_by!(ccms_code: ccms_code)
    add_matter_type_to_response(pt)
    add_proceeding_type_to_response(pt)
    add_cost_limitations_to_response(pt)
    add_scope_limitations_to_response(pt)
  end

  def add_matter_type_to_response(proceeding_type)
    matter_type = proceeding_type.matter_type
    @response[:ccms_category_law_code] = matter_type.category_of_law_code
    @response[:ccms_matter_code] = matter_type.code
    @response[:ccms_category_law] = matter_type.category_of_law
    @response[:ccms_matter] = matter_type.name
  end

  def add_proceeding_type_to_response(proceeding_type)
    @response[:ccms_code] = proceeding_type.ccms_code
    @response[:meaning] = proceeding_type.meaning
    @response[:name] = proceeding_type.name
    @response[:description] = proceeding_type.description
  end

  def add_cost_limitations_to_response(proceeding_type)
    scl = substantive_cost_limitations(proceeding_type)
    dfcl = delegated_functions_cost_limitations(proceeding_type)
    @response[:cost_limitations] = { substantive: { start_date: scl.start_date.to_s, value: scl.value.to_s },
                                     delegated_functions: { start_date: dfcl.start_date.to_s, value: dfcl.value.to_s } }
  end

  def add_scope_limitations_to_response(proceeding_type)
    scl = substantive_scope_limitations(proceeding_type)
    dfcl = delegated_functions_scope_limitations(proceeding_type)
    @response[:default_scope_limitations] = { substantive: { code: scl.code, meaning: scl.meaning, description: scl.description },
                                              delegated_functions: { code: dfcl.code, meaning: dfcl.meaning, description: dfcl.description } }
  end

  def delegated_functions_cost_limitations(proceeding_type)
    proceeding_type.default_cost_limitations.delegated_functions.for_date(Time.zone.today)
  end

  def substantive_cost_limitations(proceeding_type)
    proceeding_type.default_cost_limitations.substantive.for_date(Time.zone.today)
  end

  def delegated_functions_scope_limitations(proceeding_type)
    proceeding_type.proceeding_type_scope_limitations.default_delegated_functions_scope_limitation
  end

  def substantive_scope_limitations(proceeding_type)
    proceeding_type.proceeding_type_scope_limitations.default_substantive_scope_limitation
  end

  def skeleton_response # rubocop:disable Metrics/MethodLength
    {
      # do we need a request_id to track these requests
      success: true,
      ccms_code: '',
      meaning: '',
      ccms_category_law_code: '',
      ccms_matter_code: '',
      name: '',
      description: '',
      ccms_category_law: '',
      ccms_matter: '',
      cost_limitations: {},
      default_scope_limitations: {}
    }
  end

  def error_response_for(err)
    {
      request_id: @request_id,
      success: false,
      error_class: err.class.to_s,
      message: err.message,
      backtrace: err.backtrace
    }
  end
end
