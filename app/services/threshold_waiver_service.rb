class ThresholdWaiverService
  class ThresholdWaiverServiceError < StandardError; end

  def self.call(request_id, values)
    new(request_id, values).call
  end

  def initialize(request_id, values)
    @request_id = request_id
    @values = JSON.parse(values.to_json)
    @response = create_skeleton_response
    @converted = false
  end

  def call
    raise ThresholdWaiverServiceError, "Must specify at least one proceeding type" if @values.empty?

    @values = convert_only_ccms_codes_values unless values_have_key_value_pairs?
    @values.each { |value| add_proceeding_types_to_response(value) }
    @response
  rescue StandardError => e
    @response = error_response_for(e)
  end

private

  def create_skeleton_response
    {
      request_id: @request_id,
      success: true,
    }
  end

  def values_have_key_value_pairs?
    JSON.parse(@values.first.to_json).key?("ccms_code")
    @response[:proceedings] = []
  rescue NoMethodError
    @response[:proceeding_types] = []
    false
  end

  def convert_only_ccms_codes_values
    @converted = true
    @values.map { |x| { "ccms_code" => x.to_s, "client_involvement_type" => "A" } }
  end

  def add_proceeding_types_to_response(values)
    proceeding_type = ProceedingType.find_by!(ccms_code: values["ccms_code"])
    client_involvement_type = values["client_involvement_type"]
    waivers = get_threshold_waivers(proceeding_type, client_involvement_type)

    add_threshold_waivers(proceeding_type, client_involvement_type, waivers)
  end

  def get_threshold_waivers(proceeding_type, client_involvement_type)
    thresholds = ThresholdWaiver.find_by(matter_type: proceeding_type.matter_type, client_involvement_type:)
    {
      gross_income_upper: thresholds&.gross_income_upper || false,
      disposable_income_upper: thresholds&.disposable_income_upper || false,
      capital_upper: thresholds&.capital_upper || false,
    }
  end

  def add_threshold_waivers(proceeding_type, client_involvement_type, waivers)
    tw_hash = {
      ccms_code: proceeding_type.ccms_code,
      full_s8_only: proceeding_type.full_s8_only,
      sca_core: proceeding_type.sca_core,
      sca_related: proceeding_type.sca_related,
      matter_type: proceeding_type.matter_type.name,
    }.merge(waivers)
    tw_hash[:client_involvement_type] = client_involvement_type unless @converted

    if @converted
      @response[:proceeding_types] << tw_hash
    else
      @response[:proceedings] << tw_hash
    end
  end

  def error_response_for(err)
    {
      request_id: @request_id,
      success: false,
      error_class: err.class.to_s,
      message: err.message,
    }
  end
end
