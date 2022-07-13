class ThresholdWaiverService
  class ThresholdWaiverServiceError < StandardError; end

  def self.call(request_id, ccms_codes)
    new(request_id, ccms_codes).call
  end

  def initialize(request_id, ccms_codes)
    @request_id = request_id
    @ccms_codes = ccms_codes
    @response = create_skeleton_response
  end

  def call
    raise ThresholdWaiverServiceError, "Must specify at least one proceeding type" if @ccms_codes.empty?

    @ccms_codes.each { |ccms_code| add_proceeding_types_to_response(ccms_code) }
    @response
  rescue StandardError => e
    @response = error_response_for(e)
  end

private

  def create_skeleton_response
    {
      request_id: @request_id,
      success: true,
      proceeding_types: [],
    }
  end

  def add_proceeding_types_to_response(ccms_code)
    proceeding_type = ProceedingType.find_by!(ccms_code:)
    client_involvement_type = ClientInvolvementType.find_by!(ccms_code: "A")
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

  def add_threshold_waivers(proceeding_type, _client_involvement_type, waivers)
    tw_hash = {
      ccms_code: proceeding_type.ccms_code,
      gross_income_upper: waivers[:gross_income_upper],
      disposable_income_upper: waivers[:disposable_income_upper],
      capital_upper: waivers[:capital_upper],
      matter_type: proceeding_type.matter_type.name,
    }

    @response[:proceeding_types] << tw_hash
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
