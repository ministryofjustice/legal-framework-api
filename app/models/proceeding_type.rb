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
end
