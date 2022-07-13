class MultiThresholdWaiverService
  class MultiThresholdWaiverServiceError < StandardError; end

  def self.call(request_id, values)
    new(request_id, values).call
  end

  def initialize(request_id, values)
    @request_id = request_id
    @values = JSON.parse(values.to_json)
    @response = create_skeleton_response
  end

  def call
    raise MultiThresholdWaiverServiceError, "Must specify at least one proceeding type" if @values.empty?

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
      proceedings: [],
    }
  end

  def add_proceeding_types_to_response(values)
    proceeding_type = ProceedingType.find_by!(ccms_code: values["ccms_code"])
    client_involvement_type = ClientInvolvementType.find_by!(ccms_code: values["client_involvement_type"])

    add_threshold_waivers(proceeding_type, client_involvement_type)
  end

  def threshold_for(matter_type, client_involvement_type)
    matter_type.eql?("Domestic abuse") && client_involvement_type.ccms_code.eql?("A")
  end

  def add_threshold_waivers(proceeding_type, client_involvement_type)
    threshold = threshold_for(proceeding_type.matter_type.name, client_involvement_type)
    tw_hash = {
      ccms_code: proceeding_type.ccms_code,
      client_involvement_type: client_involvement_type.ccms_code,
      gross_income_upper: threshold,
      disposable_income_upper: threshold,
      capital_upper: threshold,
      matter_type: proceeding_type.matter_type.name,
    }

    @response[:proceedings] << tw_hash
  end

  def error_response_for(err)
    {
      request_id: @request_id,
      success: false,
      error_class: err.class.to_s,
      message: err.message,
      backtrace: err.backtrace,
    }
  end
end
