class ProceedingType < ApplicationRecord
  belongs_to :matter_type

  has_many :proceeding_type_merits_tasks, -> { order(:sequence) }, inverse_of: :proceeding_type, dependent: :destroy

  has_many :merits_tasks, through: :proceeding_type_merits_tasks

  has_many :application_tasks,
           through: :proceeding_type_merits_tasks,
           source: :merits_task,
           class_name: "ApplicationTask"

  has_many :proceeding_tasks,
           through: :proceeding_type_merits_tasks,
           source: :merits_task,
           class_name: "ProceedingTask"

  has_many :default_cost_limitations, dependent: :destroy
  has_many :proceeding_type_scope_limitations, dependent: :destroy
  has_many :eligible_scope_limitations, through: :proceeding_type_scope_limitations, source: :scope_limitation

  has_many :proceeding_type_service_levels, dependent: :destroy
  has_many :service_levels, -> { select("service_levels.*, proceeding_type_service_levels.proceeding_default as proceeding_default") },
           through: :proceeding_type_service_levels,
           source: :service_level

  def default_cost_limitation_delegated_functions
    default_cost_limitations.delegated_functions.for_date(Date.current).value
  end

  def default_cost_limitation_substantive
    default_cost_limitations.substantive.for_date(Date.current).value
  end

  UPDATE_QUERY = <<~UPDATESQL.freeze
    UPDATE proceeding_types
    SET textsearchable =
      setweight(to_tsvector(coalesce(meaning,'')), 'A')    ||
      setweight(to_tsvector(coalesce(description, '')), 'D')  ||
      setweight(to_tsvector(coalesce(additional_search_terms,'')), 'D') ||
      setweight(to_tsvector(coalesce(mt.category_of_law, '')), 'B') ||
      setweight(to_tsvector(coalesce(mt.name, '')), 'C') ||
      setweight(to_tsvector(coalesce(ccms_code, '')), 'D')
    FROM matter_types mt WHERE mt.id = proceeding_types.matter_type_id;
  UPDATESQL

  def api_json
    {
      ccms_code:,
      meaning:,
      description:,
      full_s8_only:,
      ccms_category_law: matter_type.category_of_law,
      ccms_matter_code: matter_type.code,
      ccms_matter: matter_type.name,
    }.to_json
  end

  def self.populate
    ProceedingTypePopulator.call
    refresh_text_searchable
  end

  def self.refresh_text_searchable
    connection.execute(UPDATE_QUERY)
  end
end
