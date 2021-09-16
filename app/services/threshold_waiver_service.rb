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
    raise ThresholdWaiverServiceError, 'Must specify at least one proceeding type' if @ccms_codes.empty?

    @ccms_codes.each { |ccms_code| add_threshold_waivers_to_response(ccms_code) }
    @response
  rescue StandardError => err
    @response = error_response_for(err)
  end

  private

  def create_skeleton_response
    {
      request_id: @request_id,
      success: true,
      proceeding_types: []
    }
  end

  def add_threshold_waivers_to_response(ccms_code)
    proceeding_type = ProceedingType.includes(:matter_type).find_by!(ccms_code: ccms_code)

    add_proceeding_threshold_waivers_to_response(proceeding_type)
  end

  def add_proceeding_threshold_waivers_to_response(proceeding_type)
    tw_hash = {
      code: proceeding_type.ccms_code,
      upper_gross_income_waiver: proceeding_type.matter_type.upper_gross_income_waiver.to_s,
      upper_disposable_income_waiver: proceeding_type.matter_type.upper_disposable_income_waiver.to_s,
      upper_capital_waiver: proceeding_type.matter_type.upper_capital_waiver.to_s
    }

    @response[:proceeding_types] << tw_hash
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
