class MeritsTaskPopulator
  APPLICATION_MERITS_TASKS = %w[
    latest_incident_details
    opponent_details
    children_application
    statement_of_case
    client_denial_of_allegation
    client_offer_of_undertakings
    nature_of_urgency
    why_matter_opposed
    laspo
  ].freeze

  PROCEEDING_TYPE_MERITS_TASKS = %w[
    chances_of_success
    children_proceeding
    attempts_to_settle
    specific_issue
    prohibited_steps
    opponents_application
    reason_for_new_application
    vary_order
  ].freeze

  def self.call
    new.call
  end

  def call
    APPLICATION_MERITS_TASKS.each do |mt|
      populate(mt, ApplicationTask)
    end

    PROCEEDING_TYPE_MERITS_TASKS.each do |mt|
      populate(mt, ProceedingTask)
    end
  end

private

  def populate(merits_task, klass)
    record = klass.find_by(name: merits_task) || klass.new
    record.update!(name: merits_task)
  end
end
