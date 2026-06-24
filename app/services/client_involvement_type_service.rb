class ClientInvolvementTypeService
  class ClientInvolvementTypeServiceError < StandardError; end

  def self.call(proceeding_type, age = nil)
    new(proceeding_type, age).call
  end

  def initialize(proceeding_type, age)
    @proceeding_type = proceeding_type
    @age = age
    @response = skeleton_response
  end

  def call
    proceeding = ProceedingType.find_by!(ccms_code: @proceeding_type) unless @proceeding_type.nil?

    @response[:client_involvement_type] = if proceeding&.sca_core?
                                            sca_core_response
                                          elsif proceeding&.sca_related?
                                            sca_related_response
                                          else
                                            default_response
                                          end
    @response[:client_involvement_type].reject! { |cit| cit[:ccms_code] == "W" && @age.to_i >= 18 } if @age.present?
    @response
  rescue StandardError => e
    @response = error_response_for(e)
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
