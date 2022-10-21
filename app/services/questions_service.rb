class QuestionsService
  def initialize(question_params)
    @question_params = JSON.parse(question_params, symbolize_names: true)
    @request_id =  @question_params[:request_id]
    @proceedings = @question_params[:proceedings]
    @errors = []
    @response = create_skeleton_response
  end

  def self.call(question_params)
    new(question_params).call
  end

  def call
    if json_validator.valid?
      @proceedings.each { |proceeding| add_tasks_to_response(proceeding) }
    else
      @response = error_response
      @errors.concat(json_validator.errors)
    end
    @response
  end

private

  def create_skeleton_response
    {
      request_id: @request_id,
      success: true,
      application: {
        tasks: {},
      },
      proceedings: [],
    }
  end

  def add_tasks_to_response(proceeding_hash)
    @proceeding_ccms_code = proceeding_hash[:ccms_code]
    @proceeding_cit = proceeding_hash[:client_involvement]
    proceeding_type = ProceedingType.find_by!(ccms_code: proceeding_hash[:ccms_code])
    add_application_level_tasks_to_response(proceeding_type)
    add_proceeding_level_tasks_to_response(proceeding_type, proceeding_hash[:ccms_code])
  end

  def add_application_level_tasks_to_response(proceeding_type)
    applicable_tasks = proceeding_type.application_tasks
    applicable_tasks.each do |task|
      display_rules = task.proceeding_type_merits_tasks.find_by(proceeding_type_id: proceeding_type.id).display_rules
      display_task = display_rules.nil? || send(display_rules)
      @response[:application][:tasks][task.name] = task.dependency_names if display_task
    end
  end

  def add_proceeding_level_tasks_to_response(proceeding_type, ccms_code)
    pt_hash = { ccms_code:, tasks: {} }
    proceeding_type.proceeding_tasks.each do |task|
      pt_hash[:tasks][task.name] = task.dependency_names
    end
    @response[:proceedings] << pt_hash
  end

  def domestic_abuse_with_non_applicant
    @proceedings.select { |h| h[:ccms_code].match(/DA\d{3}/) && h[:client_involvement_type] != "A" }.any?
  end

  def always_unless_all_da_and_non_applicant
    matches = @proceedings.select { |h| h[:ccms_code].match(/DA\d{3}/) && h[:client_involvement_type] != "A" }
    return true unless matches.present? && matches.all?
  end

  def error_response
    {
      request_id: @request_id,
      success: false,
      errors: @errors,
    }
  end

  def json_validator
    @json_validator ||= JsonValidator.new("civil_merits_questions", @question_params)
  end
end
