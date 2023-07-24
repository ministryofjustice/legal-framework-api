class OrganisationTypeService
  class OrganisationTypeServiceError < StandardError; end

  def self.call(ccms_code)
    new(ccms_code).call
  end

  def initialize(ccms_code)
    @ccms_code = ccms_code
    @response = skeleton_response
  end

  def call
    raise OrganisationTypeServiceError, "Must specify an organisation type" if @ccms_code.nil?

    @response[:organisation_type] = OrganisationType.find_by!(ccms_code: @ccms_code).api_json
    @response
  rescue StandardError => e
    @response = error_response_for(e)
  end

private

  def skeleton_response
    {
      success: true,
      organisation_type: {},
    }
  end

  def error_response_for(err)
    {
      request_id: @request_id,
      success: false,
      message: message_for(err),
    }
  end

  def message_for(err)
    if err.is_a?(ActiveRecord::RecordNotFound)
      "No such organisation type: '#{@ccms_code}'"
    else
      err.message
    end
  end
end
