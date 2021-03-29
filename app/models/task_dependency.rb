class TaskDependency < ApplicationRecord
  belongs_to :merits_task
  belongs_to :dependency, class_name: 'MeritsTask'
end
