class ClientInvolvementTypeService
  def self.call(proceeding_type)
    new(proceeding_type).call
  end

  def initialize(proceeding_type)
    @proceeding_type = proceeding_type
    @response = skeleton_response
  end

  def call
    return default_response if @proceeding_type.nil?

    proceeding = ProceedingType.find_by!(ccms_code: @proceeding_type)

    @response[:client_involvement_type] = if proceeding.sca_core?
                                            sca_core_response
                                          elsif proceeding.sca_related?
                                            sca_related_response
                                          else
                                            default_response
                                          end
    @response
  end

private

  def skeleton_response
    {
      success: true,
      client_involvement_type: {},
    }
  end

  def sca_core_response
    [
      {
        ccms_code: "D",
        description: "Respondent",
      },
      {
        ccms_code: "W",
        description: "Subject of proceedings (child)",
      },
    ]
  end

  def sca_related_response
    [
      {
        ccms_code: "A",
        description: "Applicant/claimant/petitioner",
      },
      {
        ccms_code: "D",
        description: "Respondent",
      },
      {
        ccms_code: "W",
        description: "Subject of proceedings (child)",
      },
    ]
  end

  def default_response
    [
      {
        ccms_code: "A",
        description: "Applicant/claimant/petitioner",
      },
      {
        ccms_code: "D",
        description: "Defendant/respondent",
      },
      {
        ccms_code: "W",
        description: "Subject of proceedings (child)",
      },
      {
        ccms_code: "I",
        description: "Intervenor",
      },
      {
        ccms_code: "Z",
        description: "Joined party",
      },
    ]
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
      "No such client involvement type: '#{@proceeding_type}'"
    else
      err.message
    end
  end
end
