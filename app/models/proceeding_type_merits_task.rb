class ProceedingTypeMeritsTask < ApplicationRecord
  belongs_to :proceeding_type, inverse_of: :proceeding_type_merits_tasks
  belongs_to :merits_task
end
