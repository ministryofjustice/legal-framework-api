class QuestionsService
  DOMESTIC_ABUSE_CODE_REGEXP = /DA\d{3}/

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
      @response[:application][:tasks][task.name] = task.dependency_names if display_rules_for(proceeding_type, task)
    end
  end

  def add_proceeding_level_tasks_to_response(proceeding_type, ccms_code)
    pt_hash = { ccms_code:, tasks: {} }
    proceeding_type.proceeding_tasks.each do |task|
      pt_hash[:tasks][task.name] = task.dependency_names if display_rules_for(proceeding_type, task)
    end
    @response[:proceedings] << pt_hash
  end

  def display_rules_for(proceeding_type, task)
    display_rules = task.proceeding_type_merits_tasks.find_by(proceeding_type_id: proceeding_type.id).display_rules
    display_rules.nil? || send(display_rules, proceeding_type)
  end

  def domestic_abuse_with_non_applicant(_proceeding)
    @proceedings.any? { |h| h[:ccms_code].match(DOMESTIC_ABUSE_CODE_REGEXP) && h[:client_involvement_type] != "A" }
  end

  def at_least_one_domestic_abuse_with_applicant(_proceeding)
    @proceedings.any? { |h| h[:ccms_code].match(DOMESTIC_ABUSE_CODE_REGEXP) && h[:client_involvement_type] == "A" }
  end

  def delegated_functions_on_any_proceeding(_proceeding)
    @proceedings.any? { |p| p[:delegated_functions_used].to_s == "true" }
  end

  def delegated_functions_and_domestic_abuse_with_non_applicant(_proceeding)
    @proceedings.any? { |p| p[:ccms_code].match(DOMESTIC_ABUSE_CODE_REGEXP) && p[:client_involvement_type] != "A" && p[:delegated_functions_used].to_s == "true" }
  end

  def applicant_or_joined_party_on_this_proceeding(proceeding)
    applicant_or_joined_party = %w[A Z]
    match = @proceedings.find { |p| p[:ccms_code] == proceeding.ccms_code && applicant_or_joined_party.include?(p[:client_involvement_type]) }
    match.present?
  end

  def unless_family_help_higher_and_or_child_subject_on_this_proceeding(proceeding)
    match = @proceedings.find { |p| p[:ccms_code] == proceeding.ccms_code && (p[:client_involvement_type] == "W" || p[:substantive_level_of_service] == 1) }
    match.nil?
  end

  def applicant_on_this_proceeding(proceeding)
    match = @proceedings.find { |p| p[:ccms_code] == proceeding.ccms_code && p[:client_involvement_type] == "A" }
    match.present?
  end

  def joined_party_on_this_proceeding(proceeding)
    match = @proceedings.find { |p| p[:ccms_code] == proceeding.ccms_code && p[:client_involvement_type] == "Z" }
    match.present?
  end

  def defendant_on_this_proceeding(proceeding)
    match = @proceedings.find { |p| p[:ccms_code] == proceeding.ccms_code && p[:client_involvement_type] == "D" }
    match.present?
  end

  def not_child_subject_for_this_proceeding(proceeding)
    match = @proceedings.find { |p| p[:ccms_code] == proceeding.ccms_code && p[:client_involvement_type] != "W" }
    match.present?
  end

  def no_domestic_abuse_proceeding(_proceeding)
    @proceedings.none? { |h| h[:ccms_code].match(DOMESTIC_ABUSE_CODE_REGEXP) }
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
