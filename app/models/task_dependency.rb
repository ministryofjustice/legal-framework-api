#
# class to record which tasks are dependent on each other
#
# merits_task: the task whose dependencies we are looking for
# dependency: the task that must be completed first, before merits task can be started.
#
class TaskDependency < ApplicationRecord
  belongs_to :merits_task
  belongs_to :dependency, class_name: "MeritsTask"
end
