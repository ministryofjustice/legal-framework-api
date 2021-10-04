class ProceedingType < ApplicationRecord
  belongs_to :matter_type

  has_many :proceeding_type_merits_tasks, -> { order(:sequence) }, inverse_of: :proceeding_type, dependent: :destroy

  has_many :merits_tasks, through: :proceeding_type_merits_tasks

  has_many :application_tasks,
           through: :proceeding_type_merits_tasks,
           source: :merits_task,
           class_name: 'ApplicationTask'

  has_many :proceeding_tasks,
           through: :proceeding_type_merits_tasks,
           source: :merits_task,
           class_name: 'ProceedingTask'

  has_many :default_cost_limitations, dependent: :destroy

  has_many :proceedings, dependent: :nullify

  def default_cost_limitation_delegated_functions
    default_cost_limitations.delegated_functions.for_date(Date.current).value
  end

  def default_cost_limitation_substantive
    default_cost_limitations.substantive.for_date(Date.current).value
  end
end
