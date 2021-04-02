class MeritsTaskService

  class MeritsTaskServiceError < StandardError; end

  def self.call(request_id, ccms_codes)
    new(request_id, ccms_codes).call
  end

  def initialize(request_id, ccms_codes)
    @request_id = request_id
    @ccms_codes  = ccms_codes
    @response = create_skeleton_response
  end


  def call
    raise MeritsTaskServiceError, 'Must specify at least one proceeding type' if @ccms_codes.empty?
    @ccms_codes.each { |ccms_code| add_tasks_to_response(ccms_code) }
    @response
  rescue => err
    @response = error_response_for(err)
  end


  private

  def create_skeleton_response
    response = {
      request_id: @request_id,
      success: true,
      application: {
        tasks: {}
      },
      proceeding_types: []
    }
    response
  end

  def add_tasks_to_response(ccms_code)
    proceeding_type = ProceedingType.find_by!(ccms_code: ccms_code)
    proceeding_type.application_tasks.each do |task|
      @response[:application][:tasks][task.name] = task.dependency_names
    end
    pt_hash = { ccms_code: ccms_code }
    proceeding_type.proceeding_tasks.each do |task|
      pt_hash[task.name] = task.dependency_names
    end
    @response[:proceeding_types] << pt_hash
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
